Return-Path: <linux-tip-commits+bounces-5599-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C303AABA3FE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 903A5508236
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15B9283CA2;
	Fri, 16 May 2025 19:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LbEWyuwe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BTxNjTkL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C90427FB2F;
	Fri, 16 May 2025 19:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424252; cv=none; b=tiMf8DGOv327jbUcleAo1vEzv3nwmR9UvTs2Haj7w1xWO9KMaStKDc2tXA5GyAtvqbN82GxLxW29yULJXd9FHUoB8twadIm4fkdmRjQIPWJJw0VUb3q17Bg30ZLh38328dVU//MsdZRyD8wZHJ7mQLuZ94Y+VNWS5KbiprwpYk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424252; c=relaxed/simple;
	bh=uUy6M1F3QeesvmamVWl6iZqf2sZeHjhpcb9uCOXsuZg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pw5p6cgkJt7GakX6t1wTPJ9tFTnrTiGYuLWjebKL2YF7XMeY0sd/62YoCW5lS8XjgB2F1i8hEEIogLGHQNPrQh7ej0bl05T6mgq44uxS7Fm4zGDQkF6QAzKbzgfpJKkT5BdaLjzzkaQZkOSCnv09qKWN1AvNJMeezYcBOENamfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LbEWyuwe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BTxNjTkL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:37:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424249;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5i+AYNJEcRNtIU3LhRaYvnEGOPNQ45a3wntCCBBQgZA=;
	b=LbEWyuwe/BRL5Ny79B8ePWvvuf2m+ugtQ85GiOmAMoQOY1PfwPRkofjPkVPR6qJqGApcal
	WLlsNu1az7DIMaar6Z6ug6X2bAQ2HqS93jA/NvAPMRS1sEW+lNeVzepQjhHUxD2JIt8hLM
	y6PoHlncqdMZOS8VBG4vAocchTqtQLkKEd4mbcHhzsoc3ywAiod+SaHerCZHJmM/gSpywx
	VIRBK/3hgkrvg0Uu4Yuzwut6LIxlD4HLfTw0E/T+CTRn+n8JcuPPCV5F28jQHv/ZV/5CC/
	5Y8hMjHKoAdeA9AE64jwqm+lSP2WNmUZSsIs1q5OjAsNuG5wnlAed/heU11w+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424249;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5i+AYNJEcRNtIU3LhRaYvnEGOPNQ45a3wntCCBBQgZA=;
	b=BTxNjTkLDTTWc0z6s2ju1bzFmG4HgdfBft7lukptwnHWeir10pH50IkDhQ6YDt8D5CuGA/
	SdMOIhZRTJNWszAw==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] irqdomain: Drop irq_domain_add_*() functions
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-41-jirislaby@kernel.org>
References: <20250319092951.37667-41-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174742424823.406.15261120811316405207.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     42b8b16fe56c206fde7fbae0116769d0addef4b7
Gitweb:        https://git.kernel.org/tip/42b8b16fe56c206fde7fbae0116769d0add=
ef4b7
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:33 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:06:11 +02:00

irqdomain: Drop irq_domain_add_*() functions

Most irq_domain_add_*() functions are unused now, so drop them. The
remaining ones are moved to the deprecated section and will be removed
during the merge window after the patches in various trees have been
merged.

Note: The Chinese docs are touched but unfinished. I cannot parse those.

[ tglx: Remove the leftover in irq-domain.rst and handle merge logistics ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-41-jirislaby@kernel.org


---
 Documentation/core-api/irq/irq-domain.rst                    |  41 +---
 Documentation/translations/zh_CN/core-api/irq/irq-domain.rst |   4 +-
 include/linux/irqdomain.h                                    | 102 ++-----
 kernel/irq/irqdomain.c                                       |  27 +--
 4 files changed, 44 insertions(+), 130 deletions(-)

diff --git a/Documentation/core-api/irq/irq-domain.rst b/Documentation/core-a=
pi/irq/irq-domain.rst
index 44f4ba5..7624607 100644
--- a/Documentation/core-api/irq/irq-domain.rst
+++ b/Documentation/core-api/irq/irq-domain.rst
@@ -42,10 +42,9 @@ irq_domain usage
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 An interrupt controller driver creates and registers an irq_domain by
-calling one of the irq_domain_add_*() or irq_domain_create_*() functions
-(each mapping method has a different allocator function, more on that later).
-The function will return a pointer to the irq_domain on success. The caller
-must provide the allocator function with an irq_domain_ops structure.
+calling one of the irq_domain_create_*() functions.  The function will
+return a pointer to the irq_domain on success. The caller must provide the
+allocator function with an irq_domain_ops structure.
=20
 In most cases, the irq_domain will begin empty without any mappings
 between hwirq and IRQ numbers.  Mappings are added to the irq_domain
@@ -92,7 +91,6 @@ Linear
=20
 ::
=20
-	irq_domain_add_linear()
 	irq_domain_create_linear()
=20
 The linear reverse map maintains a fixed size table indexed by the
@@ -105,11 +103,6 @@ map are fixed time lookup for IRQ numbers, and irq_descs=
 are only
 allocated for in-use IRQs.  The disadvantage is that the table must be
 as large as the largest possible hwirq number.
=20
-irq_domain_add_linear() and irq_domain_create_linear() are functionally
-equivalent, except for the first argument is different - the former
-accepts an Open Firmware specific 'struct device_node', while the latter
-accepts a more general abstraction 'struct fwnode_handle'.
-
 The majority of drivers should use the linear map.
=20
 Tree
@@ -117,7 +110,6 @@ Tree
=20
 ::
=20
-	irq_domain_add_tree()
 	irq_domain_create_tree()
=20
 The irq_domain maintains a radix tree map from hwirq numbers to Linux
@@ -129,11 +121,6 @@ since it doesn't need to allocate a table as large as th=
e largest
 hwirq number.  The disadvantage is that hwirq to IRQ number lookup is
 dependent on how many entries are in the table.
=20
-irq_domain_add_tree() and irq_domain_create_tree() are functionally
-equivalent, except for the first argument is different - the former
-accepts an Open Firmware specific 'struct device_node', while the latter
-accepts a more general abstraction 'struct fwnode_handle'.
-
 Very few drivers should need this mapping.
=20
 No Map
@@ -159,8 +146,6 @@ Legacy
=20
 ::
=20
-	irq_domain_add_simple()
-	irq_domain_add_legacy()
 	irq_domain_create_simple()
 	irq_domain_create_legacy()
=20
@@ -189,13 +174,13 @@ supported.  For example, ISA controllers would use the =
legacy map for
 mapping Linux IRQs 0-15 so that existing ISA drivers get the correct IRQ
 numbers.
=20
-Most users of legacy mappings should use irq_domain_add_simple() or
-irq_domain_create_simple() which will use a legacy domain only if an IRQ ran=
ge
-is supplied by the system and will otherwise use a linear domain mapping.
-The semantics of this call are such that if an IRQ range is specified then
-descriptors will be allocated on-the-fly for it, and if no range is
-specified it will fall through to irq_domain_add_linear() or
-irq_domain_create_linear() which means *no* irq descriptors will be allocate=
d.
+Most users of legacy mappings should use irq_domain_create_simple()
+which will use a legacy domain only if an IRQ range is supplied by the
+system and will otherwise use a linear domain mapping. The semantics of
+this call are such that if an IRQ range is specified then descriptors
+will be allocated on-the-fly for it, and if no range is specified it
+will fall through to irq_domain_create_linear() which means *no* irq
+descriptors will be allocated.
=20
 A typical use case for simple domains is where an irqchip provider
 is supporting both dynamic and static IRQ assignments.
@@ -206,12 +191,6 @@ that the driver using the simple domain call irq_create_=
mapping()
 before any irq_find_mapping() since the latter will actually work
 for the static IRQ assignment case.
=20
-irq_domain_add_simple() and irq_domain_create_simple() as well as
-irq_domain_add_legacy() and irq_domain_create_legacy() are functionally
-equivalent, except for the first argument is different - the former
-accepts an Open Firmware specific 'struct device_node', while the latter
-accepts a more general abstraction 'struct fwnode_handle'.
-
 Hierarchy IRQ domain
 --------------------
=20
diff --git a/Documentation/translations/zh_CN/core-api/irq/irq-domain.rst b/D=
ocumentation/translations/zh_CN/core-api/irq/irq-domain.rst
index ecb23cf..913c3ed 100644
--- a/Documentation/translations/zh_CN/core-api/irq/irq-domain.rst
+++ b/Documentation/translations/zh_CN/core-api/irq/irq-domain.rst
@@ -83,7 +83,6 @@ irq_domain=E6=98=A0=E5=B0=84=E7=9A=84=E7=B1=BB=E5=9E=8B
=20
 ::
=20
-	irq_domain_add_linear()
 	irq_domain_create_linear()
=20
 =E7=BA=BF=E6=80=A7=E5=8F=8D=E5=90=91=E6=98=A0=E5=B0=84=E7=BB=B4=E6=8A=A4=E4=
=BA=86=E4=B8=80=E4=B8=AA=E5=9B=BA=E5=AE=9A=E5=A4=A7=E5=B0=8F=E7=9A=84=E8=A1=
=A8=EF=BC=8C=E8=AF=A5=E8=A1=A8=E4=BB=A5hwirq=E5=8F=B7=E4=B8=BA=E7=B4=A2=E5=BC=
=95=E3=80=82 =E5=BD=93=E4=B8=80=E4=B8=AAhwirq=E8=A2=AB=E6=98=A0=E5=B0=84
@@ -104,7 +103,6 @@ irq_domain_add_linear()=E5=92=8Cirq_domain_create_linear(=
)=E5=9C=A8=E5=8A=9F=E8=83=BD=E4=B8=8A=E6=98=AF=E7=AD=89=E4=BB=B7=E7=9A=84=EF=
=BC=8C
=20
 ::
=20
-	irq_domain_add_tree()
 	irq_domain_create_tree()
=20
 irq_domain=E7=BB=B4=E6=8A=A4=E7=9D=80=E4=BB=8Ehwirq=E5=8F=B7=E5=88=B0Linux I=
RQ=E7=9A=84radix=E7=9A=84=E6=A0=91=E7=8A=B6=E6=98=A0=E5=B0=84=E3=80=82 =E5=BD=
=93=E4=B8=80=E4=B8=AAhwirq=E8=A2=AB=E6=98=A0=E5=B0=84=E6=97=B6=EF=BC=8C
@@ -138,8 +136,6 @@ Linux IRQ=E5=8F=B7=E7=BC=96=E5=85=A5=E7=A1=AC=E4=BB=B6=E6=
=9C=AC=E8=BA=AB=EF=BC=8C=E8=BF=99=E6=A0=B7=E5=B0=B1=E4=B8=8D=E9=9C=80=E8=A6=
=81=E6=98=A0=E5=B0=84=E4=BA=86=E3=80=82 =E8=B0=83=E7=94=A8irq_create
=20
 ::
=20
-	irq_domain_add_simple()
-	irq_domain_add_legacy()
 	irq_domain_create_simple()
 	irq_domain_create_legacy()
=20
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index f3c79f9..712c662 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -338,12 +338,6 @@ struct irq_domain *irq_domain_create_simple(struct fwnod=
e_handle *fwnode,
 					    unsigned int first_irq,
 					    const struct irq_domain_ops *ops,
 					    void *host_data);
-struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
-					 unsigned int size,
-					 unsigned int first_irq,
-					 irq_hw_number_t first_hwirq,
-					 const struct irq_domain_ops *ops,
-					 void *host_data);
 struct irq_domain *irq_domain_create_legacy(struct fwnode_handle *fwnode,
 					    unsigned int size,
 					    unsigned int first_irq,
@@ -396,40 +390,6 @@ static inline struct irq_domain *irq_find_host(struct de=
vice_node *node)
 	return d;
 }
=20
-static inline struct irq_domain *irq_domain_add_simple(struct device_node *o=
f_node,
-						       unsigned int size,
-						       unsigned int first_irq,
-						       const struct irq_domain_ops *ops,
-						       void *host_data)
-{
-	return irq_domain_create_simple(of_fwnode_handle(of_node), size, first_irq,=
 ops, host_data);
-}
-
-/**
- * irq_domain_add_linear() - Allocate and register a linear revmap irq_domai=
n.
- * @of_node: pointer to interrupt controller's device tree node.
- * @size: Number of interrupts in the domain.
- * @ops: map/unmap domain callbacks
- * @host_data: Controller private data pointer
- */
-static inline struct irq_domain *irq_domain_add_linear(struct device_node *o=
f_node,
-					 unsigned int size,
-					 const struct irq_domain_ops *ops,
-					 void *host_data)
-{
-	struct irq_domain_info info =3D {
-		.fwnode		=3D of_fwnode_handle(of_node),
-		.size		=3D size,
-		.hwirq_max	=3D size,
-		.ops		=3D ops,
-		.host_data	=3D host_data,
-	};
-	struct irq_domain *d;
-
-	d =3D irq_domain_instantiate(&info);
-	return IS_ERR(d) ? NULL : d;
-}
-
 #ifdef CONFIG_IRQ_DOMAIN_NOMAP
 static inline struct irq_domain *irq_domain_create_nomap(struct fwnode_handl=
e *fwnode,
 					 unsigned int max_irq,
@@ -452,22 +412,6 @@ static inline struct irq_domain *irq_domain_create_nomap=
(struct fwnode_handle *f
 unsigned int irq_create_direct_mapping(struct irq_domain *domain);
 #endif
=20
-static inline struct irq_domain *irq_domain_add_tree(struct device_node *of_=
node,
-					 const struct irq_domain_ops *ops,
-					 void *host_data)
-{
-	struct irq_domain_info info =3D {
-		.fwnode		=3D of_fwnode_handle(of_node),
-		.hwirq_max	=3D ~0U,
-		.ops		=3D ops,
-		.host_data	=3D host_data,
-	};
-	struct irq_domain *d;
-
-	d =3D irq_domain_instantiate(&info);
-	return IS_ERR(d) ? NULL : d;
-}
-
 static inline struct irq_domain *irq_domain_create_linear(struct fwnode_hand=
le *fwnode,
 					 unsigned int size,
 					 const struct irq_domain_ops *ops,
@@ -631,18 +575,6 @@ static inline struct irq_domain *irq_domain_create_hiera=
rchy(struct irq_domain *
 	return IS_ERR(d) ? NULL : d;
 }
=20
-static inline struct irq_domain *irq_domain_add_hierarchy(struct irq_domain =
*parent,
-					    unsigned int flags,
-					    unsigned int size,
-					    struct device_node *node,
-					    const struct irq_domain_ops *ops,
-					    void *host_data)
-{
-	return irq_domain_create_hierarchy(parent, flags, size,
-					   of_fwnode_handle(node),
-					   ops, host_data);
-}
-
 int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
 			    unsigned int nr_irqs, int node, void *arg,
 			    bool realloc,
@@ -789,6 +721,40 @@ static inline struct fwnode_handle *of_node_to_fwnode(st=
ruct device_node *node)
 	return node ? &node->fwnode : NULL;
 }
=20
+static inline struct irq_domain *irq_domain_add_tree(struct device_node *of_=
node,
+					 const struct irq_domain_ops *ops,
+					 void *host_data)
+{
+	struct irq_domain_info info =3D {
+		.fwnode		=3D of_fwnode_handle(of_node),
+		.hwirq_max	=3D ~0U,
+		.ops		=3D ops,
+		.host_data	=3D host_data,
+	};
+	struct irq_domain *d;
+
+	d =3D irq_domain_instantiate(&info);
+	return IS_ERR(d) ? NULL : d;
+}
+
+static inline struct irq_domain *irq_domain_add_linear(struct device_node *o=
f_node,
+					 unsigned int size,
+					 const struct irq_domain_ops *ops,
+					 void *host_data)
+{
+	struct irq_domain_info info =3D {
+		.fwnode		=3D of_fwnode_handle(of_node),
+		.size		=3D size,
+		.hwirq_max	=3D size,
+		.ops		=3D ops,
+		.host_data	=3D host_data,
+	};
+	struct irq_domain *d;
+
+	d =3D irq_domain_instantiate(&info);
+	return IS_ERR(d) ? NULL : d;
+}
+
 #else /* CONFIG_IRQ_DOMAIN */
 static inline void irq_dispose_mapping(unsigned int virq) { }
 static inline struct irq_domain *irq_find_matching_fwnode(
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 74ad4a8..57098c7 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -480,33 +480,6 @@ struct irq_domain *irq_domain_create_simple(struct fwnod=
e_handle *fwnode,
 }
 EXPORT_SYMBOL_GPL(irq_domain_create_simple);
=20
-/**
- * irq_domain_add_legacy() - Allocate and register a legacy revmap irq_domai=
n.
- * @of_node: pointer to interrupt controller's device tree node.
- * @size: total number of irqs in legacy mapping
- * @first_irq: first number of irq block assigned to the domain
- * @first_hwirq: first hwirq number to use for the translation. Should norma=
lly
- *               be '0', but a positive integer can be used if the effective
- *               hwirqs numbering does not begin at zero.
- * @ops: map/unmap domain callbacks
- * @host_data: Controller private data pointer
- *
- * Note: the map() callback will be called before this function returns
- * for all legacy interrupts except 0 (which is always the invalid irq for
- * a legacy controller).
- */
-struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
-					 unsigned int size,
-					 unsigned int first_irq,
-					 irq_hw_number_t first_hwirq,
-					 const struct irq_domain_ops *ops,
-					 void *host_data)
-{
-	return irq_domain_create_legacy(of_fwnode_handle(of_node), size,
-					first_irq, first_hwirq, ops, host_data);
-}
-EXPORT_SYMBOL_GPL(irq_domain_add_legacy);
-
 struct irq_domain *irq_domain_create_legacy(struct fwnode_handle *fwnode,
 					 unsigned int size,
 					 unsigned int first_irq,

