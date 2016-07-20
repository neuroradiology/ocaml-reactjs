module Low_level_bindings = struct

  let (__react, __reactDOM, __reactDOMServer) :
    'a Js.t * 'a Js.t * 'a Js.t =
    let open Js.Unsafe in
    let undef = Js.Unsafe.eval_string "undefined" in
    let require_module s =
      fun_call (js_expr "require") [|inject (Js.string s)|]
    in
    try
      (* Need to keep it this way, otherwise jsoo will optimize it
         out, also add this to js_of_ocaml *)
      Js.typeof (eval_string "window") = Js.string "undefined";
      (* In Browser *)
      global##.React,
      global##.ReactDOM,
      undef
    with Js.Error _ ->
      (* In Node *)
      (try require_module "react" with _ -> undef),
      (try require_module "react-dom" with _ -> undef),
      (try require_module "react-dom-server" with _ -> undef)

  type 'a component_api = (<isMounted : bool Js.t Js.meth; .. > as 'a) Js.t

  class type react_dom_server = object
    method renderToString :
      react_element Js.t -> Js.js_string Js.t Js.meth
    method renderToStaticMarkup :
      react_element Js.t -> Js.js_string Js.t Js.meth
  end

  and react_dom = object
    method render :
      react_element Js.t -> #Dom_html.element Js.t -> unit Js.meth
    (* method render_WithCallback : *)
    (*   react_element Js.t -> #Dom_html.element Js.t -> unit Js.meth *)

    method unmountComponentAtNode :
      #Dom_html.element Js.t -> bool Js.t Js.meth

    (* method findDOMNode : *)
    (*    Js.t -> #Dom_html.element Js.t Js.meth *)

  end

  and ['this] react = object

    method createElement_withString :
      Js.js_string Js.t -> react_element Js.t Js.meth

    method createElement_withPropsAndSingleText :
      Js.js_string Js.t ->
      <className: Js.js_string Js.t Js.readonly_prop> Js.t ->
      Js.js_string Js.t ->
      react_element Js.t Js.meth

    method createElement_WithReactClass :
      react_class Js.t -> _ Js.Opt.t -> react_element Js.t Js.meth
    method cloneElement : react_element Js.t -> react_element Js.t Js.meth
    method isValidElement : 'a Js.t -> bool Js.t Js.meth

    method createClass :
      <render :
         ('this Js.t, react_element Js.t) Js.meth_callback Js.Opt.t Js.prop;
       getInitialState :
         ('this Js.t, 'initial_state Js.t Js.Opt.t) Js.meth_callback Js.Opt.t Js.prop;
       getDefaultProps :
         ('this Js.t, 'default_props Js.t Js.Opt.t) Js.meth_callback Js.Opt.t Js.prop;
       propTypes : 'props_validator Js.t Js.Opt.t Js.readonly_prop;
       mixins : 'mixin Js.t Js.js_array Js.t Js.Opt.t Js.readonly_prop;
       statics : 'static_functions Js.t Js.Opt.t Js.readonly_prop;
       displayName : Js.js_string Js.t Js.Opt.t Js.readonly_prop;
       (* Lifecycle Methods *)
       componentWillMount :
         ('this component_api, unit Js.Opt.t) Js.meth_callback Js.Opt.t Js.prop;
       componentDidMount : ('this Js.t, unit Js.Opt.t) Js.meth_callback Js.Opt.t Js.prop;
       componentWillReceiveProps :
         ('this Js.t, 'next_props Js.t -> unit Js.Opt.t) Js.meth_callback Js.Opt.t Js.prop;
       shouldComponentUpdate :
         ('this Js.t, 'next_props Js.t -> 'next_state Js.t -> bool Js.t Js.Opt.t)
           Js.meth_callback Js.Opt.t Js.prop;
       componentWillUpdate :
         ('this Js.t, 'next_props Js.t -> 'next_state Js.t -> unit Js.Opt.t)
           Js.meth_callback Js.Opt.t Js.prop;
       componentDidUpdate :
         ('this Js.t,
          'prev_props Js.t -> 'prev_state Js.t -> unit Js.Opt.t)
           Js.meth_callback Js.Opt.t Js.prop;
       componentWillUnmount :
         ('this Js.t, unit Js.Opt.t) Js.meth_callback Js.Opt.t Js.prop; > Js.t ->
      react_class Js.t Js.meth

    method createFactory_withString :
      Js.js_string Js.t -> factory_function Js.t Js.meth
    (* method createMixin *)
    (* method _DOM a: [Function: bound ], *)
    (* abbr: [Function: bound ], *)
    (* address: [Function: bound ], *)
    (* area: [Function: bound ], *)
    (* article: [Function: bound ], *)
    (* aside: [Function: bound ], *)
    (* audio: [Function: bound ], *)
    (* b: [Function: bound ], *)
    (* base: [Function: bound ], *)
    (* bdi: [Function: bound ], *)
    (* bdo: [Function: bound ], *)
    (* big: [Function: bound ], *)
    (* blockquote: [Function: bound ], *)
    (* body: [Function: bound ], *)
    (* br: [Function: bound ], *)
    (* button: [Function: bound ], *)
    (* canvas: [Function: bound ], *)
    (* caption: [Function: bound ], *)
    (* cite: [Function: bound ], *)
    (* code: [Function: bound ], *)
    (* col: [Function: bound ], *)
    (* colgroup: [Function: bound ], *)
    (* data: [Function: bound ], *)
    (* datalist: [Function: bound ], *)
    (* dd: [Function: bound ], *)
    (* del: [Function: bound ], *)
    (* details: [Function: bound ], *)
    (* dfn: [Function: bound ], *)
    (* dialog: [Function: bound ], *)
    (* div: [Function: bound ], *)
    (* dl: [Function: bound ], *)
    (* dt: [Function: bound ], *)
    (* em: [Function: bound ], *)
    (* embed: [Function: bound ], *)
    (* fieldset: [Function: bound ], *)
    (* figcaption: [Function: bound ], *)
    (* figure: [Function: bound ], *)
    (* footer: [Function: bound ], *)
    (* form: [Function: bound ], *)
    (* h1: [Function: bound ], *)
    (* h2: [Function: bound ], *)
    (* h3: [Function: bound ], *)
    (* h4: [Function: bound ], *)
    (* h5: [Function: bound ], *)
    (* h6: [Function: bound ], *)
    (* head: [Function: bound ], *)
    (* header: [Function: bound ], *)
    (* hgroup: [Function: bound ], *)
    (* hr: [Function: bound ], *)
    (* html: [Function: bound ], *)
    (* i: [Function: bound ], *)
    (* iframe: [Function: bound ], *)
    (* img: [Function: bound ], *)
    (* input: [Function: bound ], *)
    (* ins: [Function: bound ], *)
    (* kbd: [Function: bound ], *)
    (* keygen: [Function: bound ], *)
    (* label: [Function: bound ], *)
    (* legend: [Function: bound ], *)
    (* li: [Function: bound ], *)
    (* link: [Function: bound ], *)
    (* main: [Function: bound ], *)
    (* map: [Function: bound ], *)
    (* mark: [Function: bound ], *)
    (* menu: [Function: bound ], *)
    (* menuitem: [Function: bound ], *)
    (* meta: [Function: bound ], *)
    (* meter: [Function: bound ], *)
    (* nav: [Function: bound ], *)
    (* noscript: [Function: bound ], *)
    (* object: [Function: bound ], *)
    (* ol: [Function: bound ], *)
    (* optgroup: [Function: bound ], *)
    (* option: [Function: bound ], *)
    (* output: [Function: bound ], *)
    (* p: [Function: bound ], *)
    (* param: [Function: bound ], *)
    (* picture: [Function: bound ], *)
    (* pre: [Function: bound ], *)
    (* progress: [Function: bound ], *)
    (* q: [Function: bound ], *)
    (* rp: [Function: bound ], *)
    (* rt: [Function: bound ], *)
    (* ruby: [Function: bound ], *)
    (* s: [Function: bound ], *)
    (* samp: [Function: bound ], *)
    (* script: [Function: bound ], *)
    (* section: [Function: bound ], *)
    (* select: [Function: bound ], *)
    (* small: [Function: bound ], *)
    (* source: [Function: bound ], *)
    (* span: [Function: bound ], *)
    (* strong: [Function: bound ], *)
    (* style: [Function: bound ], *)
    (* sub: [Function: bound ], *)
    (* summary: [Function: bound ], *)
    (* sup: [Function: bound ], *)
    (* table: [Function: bound ], *)
    (* tbody: [Function: bound ], *)
    (* td: [Function: bound ], *)
    (* textarea: [Function: bound ], *)
    (* tfoot: [Function: bound ], *)
    (* th: [Function: bound ], *)
    (* thead: [Function: bound ], *)
    (* time: [Function: bound ], *)
    (* title: [Function: bound ], *)
    (* tr: [Function: bound ], *)
    (* track: [Function: bound ], *)
    (* u: [Function: bound ], *)
    (* ul: [Function: bound ], *)
    (* var: [Function: bound ], *)
    (* video: [Function: bound ], *)
    (* wbr: [Function: bound ], *)
    (* circle: [Function: bound ], *)
    (* clipPath: [Function: bound ], *)
    (* defs: [Function: bound ], *)
    (* ellipse: [Function: bound ], *)
    (* g: [Function: bound ], *)
    (* image: [Function: bound ], *)
    (* line: [Function: bound ], *)
    (* linearGradient: [Function: bound ], *)
    (* mask: [Function: bound ], *)
    (* path: [Function: bound ], *)
    (* pattern: [Function: bound ], *)
    (* polygon: [Function: bound ], *)
    (* polyline: [Function: bound ], *)
    (* radialGradient: [Function: bound ], *)
    (* rect: [Function: bound ], *)
    (* stop: [Function: bound ], *)
    (* svg: [Function: bound ], *)
    (* text: [Function: bound ], *)
    (*       tspan: [Function: bound ] *)
    method version : Js.js_string Js.t Js.readonly_prop
    (* method __spread *)
    method _DOM : 'a Js.t Js.readonly_prop
  end

  and react_element = object

    method type_ : Js.js_string Js.t Js.readonly_prop
    method key : 'a Js.t Js.Opt.t Js.prop
    (* method ref : react_element_ref Js.t Js.Opt.t Js.prop *)

  end

  and react_class = object

  end

  and factory_function = object

  end

  let react : _ react Js.t = __react

  let reactDOM : react_dom Js.t = __reactDOM

  (* Only makes sense on the server, hence the unit *)
  let reactDOMServer : unit -> react_dom_server Js.t = fun () -> __reactDOMServer

end

let debug thing field =
  Firebug.console##log
    (Js.Unsafe.(meth_call (get thing field) "toString" [||]))

type element_spec = { class_name: string option; } [@@deriving make]

type children = [`Text_nodes of string list
                | `Kids of Low_level_bindings.react_element Js.t list ]

type ('this,
      'initial_state,
      'default_props,
      'prop_types,
      'static_functions,
      'next_props,
      'next_state,
      'prev_props,
      'prev_state,
      'props,
      'mixin) class_spec =
  { render: 'this Js.t -> Low_level_bindings.react_element Js.t; [@main]
        initial_state : ('this Js.t -> 'initial_state Js.t) option;
      default_props : ('this Js.t -> 'default_props Js.t) option;
      prop_types : 'prop_types Js.t option;
      mixins : 'mixin Js.t list option;
      statics : 'static_functions Js.t option;
      display_name : string option;
      component_will_mount : ('this Js.t -> unit) option;
      component_did_mount : ('this Js.t -> unit) option;
      component_will_receive_props : ('this Js.t -> 'next_props Js.t -> unit) option;
      should_component_update :
        ('this Js.t -> 'next_props Js.t -> 'next_state Js.t -> bool Js.t) option;
      component_will_update :
        ('this Js.t -> 'next_props Js.t -> 'next_state Js.t -> unit) option;
      component_did_update :
        ('this Js.t -> 'prev_props Js.t -> 'prev_state Js.t -> unit) option;
      component_will_unmount : ('this Js.t -> unit) option;} [@@deriving make]

let create_element
    elem_name element_opts (children : children) :
  Low_level_bindings.react_element Js.t =
  let open Js.Unsafe in
  let arr = (match children with
      | `Text_nodes s -> List.map Js.string s
      | _ -> [])
            |> Array.of_list |> Array.map inject
  in
  (Array.append
     [|
       inject ((Js.string elem_name));
       inject (object%js(self)
         val className =
           Js.Opt.(map (option element_opts.class_name) Js.string)
       end);
     |]
     arr
  )
  |> Js.Unsafe.meth_call Low_level_bindings.__react "createElement"

let create_element_from_class class_ =
  Low_level_bindings.react##createElement_WithReactClass class_ Js.null


let create_class class_opts = let open Js.Opt in
  let comp = (object%js
    (* Component Specifications  *)
    val mutable render = Js.null
    val mutable getInitialState = Js.null
    val mutable getDefaultProps = Js.null
    val propTypes = map (option class_opts.prop_types) (fun s -> s)
    val mixins =
      map (option class_opts.mixins) (fun m -> Array.of_list m |> Js.array)
    val statics = map (option class_opts.statics) (fun s -> s)
    val displayName = map (option class_opts.display_name) Js.string
    (* Lifecycle Methods *)
    val mutable componentWillMount = Js.null
    val mutable componentDidMount = Js.null
    val mutable componentWillReceiveProps = Js.null
    val mutable shouldComponentUpdate = Js.null
    val mutable componentWillUpdate = Js.null
    val mutable componentDidUpdate = Js.null
    val mutable componentWillUnmount = Js.null
  end)
  in
  (* Yay *)
  comp##.render :=
    Js.wrap_meth_callback (fun this -> class_opts.render this)
    |> return;

  comp##.getInitialState :=
    Js.wrap_meth_callback
      (fun this -> map (option class_opts.initial_state) (fun f -> f this))
    |> return;

  comp##.getDefaultProps :=
    Js.wrap_meth_callback
      (fun this -> map (option class_opts.default_props) (fun f -> f this))
    |> return;

  comp##.componentWillMount :=
    Js.wrap_meth_callback
      (fun this -> map (option class_opts.component_will_mount) (fun f -> f this))
    |> return;

  comp##.componentDidMount :=
    Js.wrap_meth_callback
      (fun this -> map (option class_opts.component_did_mount) (fun f -> f this))
    |> return;

  comp##.componentWillReceiveProps :=
    Js.wrap_meth_callback
      (fun this next_props ->
         map
           (option class_opts.component_will_receive_props)
           (fun f -> f this next_props))
    |> return;

  comp##.shouldComponentUpdate :=
    Js.wrap_meth_callback
      (fun this next_props next_state ->
         map
           (option class_opts.should_component_update)
           (fun f -> f this next_props next_state))
    |> return;

  comp##.componentWillUpdate :=
    Js.wrap_meth_callback
      (fun this next_props next_state ->
         map
           (option class_opts.component_will_update)
           (fun f -> f this next_props next_state))
    |> return;

  comp##.componentDidUpdate :=
    Js.wrap_meth_callback
      (fun this prev_props prev_state ->
         map
           (option class_opts.component_did_update)
           (fun f -> f this prev_props prev_state))
    |> return;

  comp##.componentWillUnmount :=
    Js.wrap_meth_callback
      (fun this ->
         map
           (option class_opts.component_will_unmount)
           (fun f -> f this))
    |> return;

  Low_level_bindings.react##createClass comp

(* class react_class class_spec = object *)

(*   val js_object = create_class class_spec *)

(*   method unsafe_react_class = js_object *)

(* end *)

(* class react_elem react_class = object *)

(*   val js_object = create_element_from_class react_class *)

(*   method unsafe_react_elem = js_object *)

(* end *)

(* let render (element : react_elem) dom_elem = *)
(*   Low_level_bindings.reactDOM##render element#unsafe_react_elem dom_elem *)

let render element dom_elem =
  Low_level_bindings.reactDOM##render element dom_elem

module DOM = struct

  (* type tag = [`p | `div] [@@deriving show] *)

  (* let without_tick ~tag:tag tag_f = *)
  (*   (tag_f tag |> Js.string)##substring_toEnd 1 |> Js.to_string *)


  let p :
    ?elem_spec:element_spec
    -> children
    -> Low_level_bindings.react_element Js.t =
    fun ?(elem_spec=make_element_spec ()) c ->
      let open Js.Opt in
      let spec_obj =
        object%js
          val className = map (option elem_spec.class_name) Js.string
        end
      in
      let arr =
        (match c with
         | `Text_nodes s -> List.map Js.string s
         | _ -> [])
        |> Array.of_list |> Array.map Js.Unsafe.inject
      in
      Js.Unsafe.meth_call
        Low_level_bindings.react##._DOM
        "p"
        (Array.append
           [|
             Js.Unsafe.inject spec_obj;
           |]
           arr
        )


end
