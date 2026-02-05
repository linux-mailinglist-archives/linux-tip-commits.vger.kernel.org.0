Return-Path: <linux-tip-commits+bounces-8210-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHNFCwfChGnG4wMAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8210-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 05 Feb 2026 17:15:03 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 991CEF515F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 05 Feb 2026 17:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76AA1303B4F5
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Feb 2026 16:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F0C438FF4;
	Thu,  5 Feb 2026 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nWogRWPU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fc/ts5Jn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA03438FED;
	Thu,  5 Feb 2026 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770308044; cv=none; b=PGZcXCRdNRr8bF52pQvcALKZndozricBFX0zwFDQsYzW8eCvcJzPUOxC5ID3Jo3csZLflx0S6BNcQq9OV5aTkP7nxPmDALRqAiaSGJf9LvnSsKKv231ENEDpzU29DX0mklcXUyPiJTWrgv9LvuBVg/ioQXlYL0BRqP6vlypo90Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770308044; c=relaxed/simple;
	bh=l9y/s5SHYIxyHh819mEh38PPhLvkxxaYE2E+MxFgOPk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WnZpOU2HuEGkAZmT9of17SNZynNKd/HqJn8b2VZHsdoCzloZ8G+uX3HHOhuDhSCTq0RrHA79JHLxbhRYtbmOE4n6iGmwglc9h5K2L201+aUnKKZqF7aVdtwLL+9E4i4zb4hqtyoq76y47CuR/Bh0GqgTWD00YNx5ZVAdrG1hii4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nWogRWPU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fc/ts5Jn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Feb 2026 16:14:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770308042;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M00opKmdGnD2TXMlw6VWpqDV1O3icD8oDQmy7jz1Khg=;
	b=nWogRWPU4HfAWMvJEYUaHXRzc9I61rxsuVB7Qpxd3CstGyKiuxOro2UQnP45amIO3NDaqu
	I0eXtre8d3OQnfEmB4fCEWAq2tPvrtQ1bJmOJt1KJpU1r0ukxgQNBrYXeyWItrkunmW0/X
	n/P6m99DEcbykNtqiQdZ+MfkeooMcqWDiTJu52yjeDtNBptwqUnFRu3v3p0wT3zCC6ufgh
	hr2rPlq7u8lQATDX5Qph0uDggbMJ2cosZleMgtDj00eTeAslutCNu4Z4xfDUzyI6GMgZpO
	HgyIGEL4KV+MfFLD2649A17zsEunD0T3sfwEDrsVlzn1m4/wTitSSvcJLD6FsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770308042;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M00opKmdGnD2TXMlw6VWpqDV1O3icD8oDQmy7jz1Khg=;
	b=fc/ts5JnmZ/9yJKYg636paN84HwZDtNsmmiYT4BqUR4YU30ODrl6EcVVwBoAaazrv+lBe2
	Y0/S4/OdoWkCR6Bg==
From: "tip-bot2 for Petr Pavlu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] livepatch: Fix having __klp_objects relics in
 non-livepatch modules
Cc: Petr Pavlu <petr.pavlu@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Miroslav Benes <mbenes@suse.cz>, Aaron Tomlin <atomlin@atomlin.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260123102825.3521961-2-petr.pavlu@suse.com>
References: <20260123102825.3521961-2-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177030804144.2495410.890133052005289018.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8210-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,atomlin.com:email,suse.com:email,linutronix.de:dkim,suse.cz:email,msgid.link:url,vger.kernel.org:replyto]
X-Rspamd-Queue-Id: 991CEF515F
X-Rspamd-Action: no action

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     ab10815472fcbc2c772dc21a979460b7f74f0145
Gitweb:        https://git.kernel.org/tip/ab10815472fcbc2c772dc21a979460b7f74=
f0145
Author:        Petr Pavlu <petr.pavlu@suse.com>
AuthorDate:    Fri, 23 Jan 2026 11:26:56 +01:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Thu, 05 Feb 2026 08:00:44 -08:00

livepatch: Fix having __klp_objects relics in non-livepatch modules

The linker script scripts/module.lds.S specifies that all input
__klp_objects sections should be consolidated into an output section of
the same name, and start/stop symbols should be created to enable
scripts/livepatch/init.c to locate this data.

This start/stop pattern is not ideal for modules because the symbols are
created even if no __klp_objects input sections are present.
Consequently, a dummy __klp_objects section also appears in the
resulting module. This unnecessarily pollutes non-livepatch modules.

Instead, since modules are relocatable files, the usual method for
locating consolidated data in a module is to read its section table.
This approach avoids the aforementioned problem.

The klp_modinfo already stores a copy of the entire section table with
the final addresses. Introduce a helper function that
scripts/livepatch/init.c can call to obtain the location of the
__klp_objects section from this data.

Fixes: dd590d4d57eb ("objtool/klp: Introduce klp diff subcommand for diffing =
object files")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
Acked-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
Link: https://patch.msgid.link/20260123102825.3521961-2-petr.pavlu@suse.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/livepatch.h |  3 +++
 kernel/livepatch/core.c   | 19 +++++++++++++++++++
 scripts/livepatch/init.c  | 20 +++++++++-----------
 scripts/module.lds.S      |  7 +------
 4 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index 772919e..ba9e398 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -175,6 +175,9 @@ int klp_enable_patch(struct klp_patch *);
 int klp_module_coming(struct module *mod);
 void klp_module_going(struct module *mod);
=20
+void *klp_find_section_by_name(const struct module *mod, const char *name,
+			       size_t *sec_size);
+
 void klp_copy_process(struct task_struct *child);
 void klp_update_patch_state(struct task_struct *task);
=20
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 9917756..1acbad2 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -1356,6 +1356,25 @@ void klp_module_going(struct module *mod)
 	mutex_unlock(&klp_mutex);
 }
=20
+void *klp_find_section_by_name(const struct module *mod, const char *name,
+			       size_t *sec_size)
+{
+	struct klp_modinfo *info =3D mod->klp_info;
+
+	for (int i =3D 1; i < info->hdr.e_shnum; i++) {
+		Elf_Shdr *shdr =3D &info->sechdrs[i];
+
+		if (!strcmp(info->secstrings + shdr->sh_name, name)) {
+			*sec_size =3D shdr->sh_size;
+			return (void *)shdr->sh_addr;
+		}
+	}
+
+	*sec_size =3D 0;
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(klp_find_section_by_name);
+
 static int __init klp_init(void)
 {
 	klp_root_kobj =3D kobject_create_and_add("livepatch", kernel_kobj);
diff --git a/scripts/livepatch/init.c b/scripts/livepatch/init.c
index 2274d8f..9e315fc 100644
--- a/scripts/livepatch/init.c
+++ b/scripts/livepatch/init.c
@@ -9,19 +9,19 @@
 #include <linux/slab.h>
 #include <linux/livepatch.h>
=20
-extern struct klp_object_ext __start_klp_objects[];
-extern struct klp_object_ext __stop_klp_objects[];
-
 static struct klp_patch *patch;
=20
 static int __init livepatch_mod_init(void)
 {
+	struct klp_object_ext *obj_exts;
+	size_t obj_exts_sec_size;
 	struct klp_object *objs;
 	unsigned int nr_objs;
 	int ret;
=20
-	nr_objs =3D __stop_klp_objects - __start_klp_objects;
-
+	obj_exts =3D klp_find_section_by_name(THIS_MODULE, "__klp_objects",
+					    &obj_exts_sec_size);
+	nr_objs =3D obj_exts_sec_size / sizeof(*obj_exts);
 	if (!nr_objs) {
 		pr_err("nothing to patch!\n");
 		ret =3D -EINVAL;
@@ -41,7 +41,7 @@ static int __init livepatch_mod_init(void)
 	}
=20
 	for (int i =3D 0; i < nr_objs; i++) {
-		struct klp_object_ext *obj_ext =3D __start_klp_objects + i;
+		struct klp_object_ext *obj_ext =3D obj_exts + i;
 		struct klp_func_ext *funcs_ext =3D obj_ext->funcs;
 		unsigned int nr_funcs =3D obj_ext->nr_funcs;
 		struct klp_func *funcs =3D objs[i].funcs;
@@ -90,12 +90,10 @@ err:
=20
 static void __exit livepatch_mod_exit(void)
 {
-	unsigned int nr_objs;
-
-	nr_objs =3D __stop_klp_objects - __start_klp_objects;
+	struct klp_object *obj;
=20
-	for (int i =3D 0; i < nr_objs; i++)
-		kfree(patch->objs[i].funcs);
+	klp_for_each_object_static(patch, obj)
+		kfree(obj->funcs);
=20
 	kfree(patch->objs);
 	kfree(patch);
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 3037d5e..383d19b 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -35,12 +35,7 @@ SECTIONS {
 	__patchable_function_entries : { *(__patchable_function_entries) }
=20
 	__klp_funcs		0: ALIGN(8) { KEEP(*(__klp_funcs)) }
-
-	__klp_objects		0: ALIGN(8) {
-		__start_klp_objects =3D .;
-		KEEP(*(__klp_objects))
-		__stop_klp_objects =3D .;
-	}
+	__klp_objects		0: ALIGN(8) { KEEP(*(__klp_objects)) }
=20
 #ifdef CONFIG_ARCH_USES_CFI_TRAPS
 	__kcfi_traps		: { KEEP(*(.kcfi_traps)) }

