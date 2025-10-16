Return-Path: <linux-tip-commits+bounces-6863-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 859FBBE2870
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06F2B4FFDDE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E92C32038D;
	Thu, 16 Oct 2025 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="umnnat33";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dKTz1Xq7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B39131D386;
	Thu, 16 Oct 2025 09:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608338; cv=none; b=lwGvQqId0q3I+hTof1QD7F64BwryFJE3Nz9It5G/3Zy3wB07Nev/XoaMV0fTnGONXgrlp4Xu+BZFlxEIJSfrEH0nDGCe+Exgd0WYBfLcv57yihydUEm+UqmaKBebFGJxU23LHhNEStAYkEU4QfCA5xeopGjnBeaB+p9q4vziNoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608338; c=relaxed/simple;
	bh=HR5nIMKCSUcgdRF4UT26KwJNnFpMDeK3a7/s5CNcCDw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=CyexwAllWhvK0OZnztv/KzGYnkTJdcFFnz9gWpuZ4/OFmIwRUhy85kXTAKfbwGgFlToAclyYLbjbIyisSpZJXcLUDG7wkLCiQqqrRoja7zfP10iRfSdfTeIInlPXnGuDdEmYOVm1vyV6UY5U46fPaxgB6QMgGzudX3Hht/4aY84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=umnnat33; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dKTz1Xq7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608327;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=jprMeAnOi85T0xqWVdSEJNdCCZ6L38XLrk/MQIwaTbE=;
	b=umnnat33VhRoMsvH/Gd7VNAEo6BEZ+m41CGluh+5efhOV/3hQZmRizJ4ObZ1itG/BNjRma
	PQDDvSCauuZ092543x6sbFHWgb+O/+Z2HlwMgtRh6RM+2qMXOA66gMAyG9BuCNEQiZyZ/3
	P88Syrto8sxhcqgpjQFXbqAj3KXZ/86fDahCIbjFNdi/Wdot6vvomwkZ37wzVvcIDtiGgj
	g9qrTX1eMgqlU0QOU0n5rkQv7zhB9KNYRbHtckKKdUI1pLKCM+8i2wUmWs97FKom7+AJdP
	L4kynR1UeL2yiaEmOwF8qK2pb5c7I6BRkeYwv5+4F0kw4XVcCW6Hp5dYyuKoJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608327;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=jprMeAnOi85T0xqWVdSEJNdCCZ6L38XLrk/MQIwaTbE=;
	b=dKTz1Xq7Ogj/SkjXC7sOI9Hipa9B9kEUAw6l53ZoNN8VzP3scPaIA0ZTSEWAa3nfJdjiKC
	9b8qH7EOXw0mljAQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] livepatch/klp-build: Add stub init code for
 livepatch modules
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060832614.709179.8750464085170794957.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     59adee07b568fb78e2bf07df1f22f3fe45b7240a
Gitweb:        https://git.kernel.org/tip/59adee07b568fb78e2bf07df1f22f3fe45b=
7240a
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:04:07 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:50:19 -07:00

livepatch/klp-build: Add stub init code for livepatch modules

Add a module initialization stub which can be linked with binary diff
objects to produce a livepatch module.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/livepatch/init.c | 108 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 108 insertions(+)
 create mode 100644 scripts/livepatch/init.c

diff --git a/scripts/livepatch/init.c b/scripts/livepatch/init.c
new file mode 100644
index 0000000..2274d8f
--- /dev/null
+++ b/scripts/livepatch/init.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Init code for a livepatch kernel module
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/livepatch.h>
+
+extern struct klp_object_ext __start_klp_objects[];
+extern struct klp_object_ext __stop_klp_objects[];
+
+static struct klp_patch *patch;
+
+static int __init livepatch_mod_init(void)
+{
+	struct klp_object *objs;
+	unsigned int nr_objs;
+	int ret;
+
+	nr_objs =3D __stop_klp_objects - __start_klp_objects;
+
+	if (!nr_objs) {
+		pr_err("nothing to patch!\n");
+		ret =3D -EINVAL;
+		goto err;
+	}
+
+	patch =3D kzalloc(sizeof(*patch), GFP_KERNEL);
+	if (!patch) {
+		ret =3D -ENOMEM;
+		goto err;
+	}
+
+	objs =3D kzalloc(sizeof(struct klp_object) * (nr_objs + 1),  GFP_KERNEL);
+	if (!objs) {
+		ret =3D -ENOMEM;
+		goto err_free_patch;
+	}
+
+	for (int i =3D 0; i < nr_objs; i++) {
+		struct klp_object_ext *obj_ext =3D __start_klp_objects + i;
+		struct klp_func_ext *funcs_ext =3D obj_ext->funcs;
+		unsigned int nr_funcs =3D obj_ext->nr_funcs;
+		struct klp_func *funcs =3D objs[i].funcs;
+		struct klp_object *obj =3D objs + i;
+
+		funcs =3D kzalloc(sizeof(struct klp_func) * (nr_funcs + 1), GFP_KERNEL);
+		if (!funcs) {
+			ret =3D -ENOMEM;
+			for (int j =3D 0; j < i; j++)
+				kfree(objs[i].funcs);
+			goto err_free_objs;
+		}
+
+		for (int j =3D 0; j < nr_funcs; j++) {
+			funcs[j].old_name   =3D funcs_ext[j].old_name;
+			funcs[j].new_func   =3D funcs_ext[j].new_func;
+			funcs[j].old_sympos =3D funcs_ext[j].sympos;
+		}
+
+		obj->name =3D obj_ext->name;
+		obj->funcs =3D funcs;
+
+		memcpy(&obj->callbacks, &obj_ext->callbacks, sizeof(struct klp_callbacks));
+	}
+
+	patch->mod =3D THIS_MODULE;
+	patch->objs =3D objs;
+
+	/* TODO patch->states */
+
+#ifdef KLP_NO_REPLACE
+	patch->replace =3D false;
+#else
+	patch->replace =3D true;
+#endif
+
+	return klp_enable_patch(patch);
+
+err_free_objs:
+	kfree(objs);
+err_free_patch:
+	kfree(patch);
+err:
+	return ret;
+}
+
+static void __exit livepatch_mod_exit(void)
+{
+	unsigned int nr_objs;
+
+	nr_objs =3D __stop_klp_objects - __start_klp_objects;
+
+	for (int i =3D 0; i < nr_objs; i++)
+		kfree(patch->objs[i].funcs);
+
+	kfree(patch->objs);
+	kfree(patch);
+}
+
+module_init(livepatch_mod_init);
+module_exit(livepatch_mod_exit);
+MODULE_LICENSE("GPL");
+MODULE_INFO(livepatch, "Y");
+MODULE_DESCRIPTION("Livepatch module");

