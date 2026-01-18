Return-Path: <linux-tip-commits+bounces-8060-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCBFD393D2
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 11:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F2EF300A9B2
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 10:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7153A2DE6F1;
	Sun, 18 Jan 2026 10:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4dPz5tKn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rGDhMpUI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5DF2D9EE7;
	Sun, 18 Jan 2026 10:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768730970; cv=none; b=qa83WxQITKsJgaNVeMKENqQj0iw2ijB0DI0rbtBqxDYhu5ow+7iMATvJTLOUPD6eQzIe33lM3eyd+udOdfP3OUuPsQW5F0WfQO7vNkKUBH8+EC7uEPih26EUOOM2JDeERkbQ07vIGlHzwYoZw8w/xoPvoxbY82mRW9CAVvfFr6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768730970; c=relaxed/simple;
	bh=ScSgF0UUf9+Nl3zXMi4vaF5ZpoHk/yQ6Y+gg8bNIchE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DbMTuxaSfgiJS0V4kezR43k2Cd7+M8T80H/jSshXKd968+vqbOQp7qb8Qqk3m/MKAjObLbZm4LohQSSq5ydSML6wethDWs18aQgOXS/ZNMh1UF+e7PWp56IhRQ4eKXGWxFWlhlTZfu6BmJUrNC+Ap42exOP/95NZNFL3d57dJmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4dPz5tKn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rGDhMpUI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Jan 2026 10:09:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768730966;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V7+F4o2BnMfI7hw9GQASzv6mrh9cf/twOfwu4BhZHlQ=;
	b=4dPz5tKnZgYPdp30daXWZsztkOrqxKiiepobj1w6rZn/BOuiFzFBGHkbA3QfYOEHQKGStR
	/tYT28lHvqYnPpngHLlsuEM3Qj6UPxqqvsprNnBqR69oy5urb78Wffjvq5LwupsQYTGNEl
	pFMlu8Ac2kX3LYizQucLlj7x8VCEr1j5xjcPiXCX1AoVbpA6jFwtWlDbIthw6LLFFEVBQe
	DlAYRWes96+hGXQdzwDDa8cNJXOVnU8wlHwcNhu/2Xq7gKzPofo0krZovc1j4i+2zWqclp
	cLiZn1SXH8GqyFMNtMF3TVUZg33Ys5eCNNFtIKb9yQHlz9w78WhGKGVPXHWajg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768730966;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V7+F4o2BnMfI7hw9GQASzv6mrh9cf/twOfwu4BhZHlQ=;
	b=rGDhMpUI31kHuvtQ0A1EWE7rUGJBxXJTJJtOSMA9cIz56249JDBQQfaHcHpNR2+78QCD9O
	i4u4rr4s/dl83VBQ==
From: "tip-bot2 for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] irqdomain: Add parent field to struct irqchip_fwid
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260115-gicv5-host-acpi-v3-1-c13a9a150388@kernel.org>
References: <20260115-gicv5-host-acpi-v3-1-c13a9a150388@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176873096552.510.6742869475936924219.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     22056f655700360518cc8df344ff640b0fb3499e
Gitweb:        https://git.kernel.org/tip/22056f655700360518cc8df344ff640b0fb=
3499e
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Thu, 15 Jan 2026 10:50:47 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 18 Jan 2026 11:07:56 +01:00

irqdomain: Add parent field to struct irqchip_fwid

The GICv5 driver interrupt domain hierarchy requires adding a parent field
to struct irqchip_fwid so that the core code can reference a fwnode_handle
parent for a given fwnode.

Add a parent field to struct irqchip_fwid and update the related kernel API
functions to initialize and handle it.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Link: https://patch.msgid.link/20260115-gicv5-host-acpi-v3-1-c13a9a150388@ker=
nel.org
---
 include/linux/irqdomain.h | 30 ++++++++++++++++++++++++++----
 kernel/irq/irqdomain.c    | 14 +++++++++++++-
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 62f81bb..73c25d4 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -257,7 +257,8 @@ static inline void irq_domain_set_pm_device(struct irq_do=
main *d, struct device=20
=20
 #ifdef CONFIG_IRQ_DOMAIN
 struct fwnode_handle *__irq_domain_alloc_fwnode(unsigned int type, int id,
-						const char *name, phys_addr_t *pa);
+						const char *name, phys_addr_t *pa,
+						struct fwnode_handle *parent);
=20
 enum {
 	IRQCHIP_FWNODE_REAL,
@@ -267,18 +268,39 @@ enum {
=20
 static inline struct fwnode_handle *irq_domain_alloc_named_fwnode(const char=
 *name)
 {
-	return __irq_domain_alloc_fwnode(IRQCHIP_FWNODE_NAMED, 0, name, NULL);
+	return __irq_domain_alloc_fwnode(IRQCHIP_FWNODE_NAMED, 0, name, NULL, NULL);
+}
+
+static inline
+struct fwnode_handle *irq_domain_alloc_named_parented_fwnode(const char *nam=
e,
+							     struct fwnode_handle *parent)
+{
+	return __irq_domain_alloc_fwnode(IRQCHIP_FWNODE_NAMED, 0, name, NULL, paren=
t);
 }
=20
 static inline struct fwnode_handle *irq_domain_alloc_named_id_fwnode(const c=
har *name, int id)
 {
 	return __irq_domain_alloc_fwnode(IRQCHIP_FWNODE_NAMED_ID, id, name,
-					 NULL);
+					 NULL, NULL);
+}
+
+static inline
+struct fwnode_handle *irq_domain_alloc_named_id_parented_fwnode(const char *=
name, int id,
+								struct fwnode_handle *parent)
+{
+	return __irq_domain_alloc_fwnode(IRQCHIP_FWNODE_NAMED_ID, id, name,
+					 NULL, parent);
 }
=20
 static inline struct fwnode_handle *irq_domain_alloc_fwnode(phys_addr_t *pa)
 {
-	return __irq_domain_alloc_fwnode(IRQCHIP_FWNODE_REAL, 0, NULL, pa);
+	return __irq_domain_alloc_fwnode(IRQCHIP_FWNODE_REAL, 0, NULL, pa, NULL);
+}
+
+static inline struct fwnode_handle *irq_domain_alloc_parented_fwnode(phys_ad=
dr_t *pa,
+								     struct fwnode_handle *parent)
+{
+	return __irq_domain_alloc_fwnode(IRQCHIP_FWNODE_REAL, 0, NULL, pa, parent);
 }
=20
 void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 2652c4c..baf77cd 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -33,6 +33,7 @@ static void irq_domain_free_one_irq(struct irq_domain *doma=
in, unsigned int virq
=20
 struct irqchip_fwid {
 	struct fwnode_handle	fwnode;
+	struct fwnode_handle	*parent;
 	unsigned int		type;
 	char			*name;
 	phys_addr_t		*pa;
@@ -53,8 +54,16 @@ static const char *irqchip_fwnode_get_name(const struct fw=
node_handle *fwnode)
 	return fwid->name;
 }
=20
+static struct fwnode_handle *irqchip_fwnode_get_parent(const struct fwnode_h=
andle *fwnode)
+{
+	struct irqchip_fwid *fwid =3D container_of(fwnode, struct irqchip_fwid, fwn=
ode);
+
+	return fwid->parent;
+}
+
 const struct fwnode_operations irqchip_fwnode_ops =3D {
 	.get_name =3D irqchip_fwnode_get_name,
+	.get_parent =3D irqchip_fwnode_get_parent,
 };
 EXPORT_SYMBOL_GPL(irqchip_fwnode_ops);
=20
@@ -65,6 +74,7 @@ EXPORT_SYMBOL_GPL(irqchip_fwnode_ops);
  * @id:		Optional user provided id if name !=3D NULL
  * @name:	Optional user provided domain name
  * @pa:		Optional user-provided physical address
+ * @parent:	Optional parent fwnode_handle
  *
  * Allocate a struct irqchip_fwid, and return a pointer to the embedded
  * fwnode_handle (or NULL on failure).
@@ -76,7 +86,8 @@ EXPORT_SYMBOL_GPL(irqchip_fwnode_ops);
  */
 struct fwnode_handle *__irq_domain_alloc_fwnode(unsigned int type, int id,
 						const char *name,
-						phys_addr_t *pa)
+						phys_addr_t *pa,
+						struct fwnode_handle *parent)
 {
 	struct irqchip_fwid *fwid;
 	char *n;
@@ -104,6 +115,7 @@ struct fwnode_handle *__irq_domain_alloc_fwnode(unsigned =
int type, int id,
 	fwid->type =3D type;
 	fwid->name =3D n;
 	fwid->pa =3D pa;
+	fwid->parent =3D parent;
 	fwnode_init(&fwid->fwnode, &irqchip_fwnode_ops);
 	return &fwid->fwnode;
 }

