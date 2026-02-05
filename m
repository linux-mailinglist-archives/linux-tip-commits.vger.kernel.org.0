Return-Path: <linux-tip-commits+bounces-8209-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDBSLePBhGnG4wMAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8209-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 05 Feb 2026 17:14:27 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AEAF512B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 05 Feb 2026 17:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0449F3009398
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Feb 2026 16:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F15436376;
	Thu,  5 Feb 2026 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EODrc+tp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Put2Y4d7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FE343636D;
	Thu,  5 Feb 2026 16:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770308043; cv=none; b=AREIc38iYjrg0FCdjcTvLffOeGZ29ApVGJF/l7q0goNBTb8OdRn4BKyotT9Z8fu8RbAue4HqAechaCdwS6BZ22aH3fMpDPMU8Q9pulYFTvw1LXCjv3ejtwhiskaUoZAtfqu1wtaro9P8QXzFAcouSMnXsytFO98POdz/uHh9ywI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770308043; c=relaxed/simple;
	bh=kDa8udc5z2YmIyQAxGaI00yTMNNNnP/5XArmK/LVmEY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NRIvOSISt03BzIC2riVrKrkTsAJbAyOuQjJ6FJsA4+TPGWzpbvHxtX/tcPQ7r6+AMM/tkaMd3FNRNWz+h09K5NrcubcBTKhE07ijr6ppgBWg+XuNKYgMgMwDFEG+1LTqARFqSaziSO7eKp8mBPG5sK2su5hgfqSY2u94fB46iC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EODrc+tp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Put2Y4d7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Feb 2026 16:14:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770308041;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YIUry9ulEPJqzFPc7F31WKS7Dgo0bIDuJCWRBgf7Ls0=;
	b=EODrc+tp3dQWHXBf0SBsYgVKj6COE53ZCq33vCB53oX+V/XxmJRD0Cu6qnT2mXFe4/1rni
	rmYO3xocHC/PTtniWl4AsySVD9UYMfVsd+kGUiSLCRfSbNodF1+yTBb2XnBPGSc7yy2svV
	WNLxDmp6jwjq/9+fzhhFl4u51buF6JCpQn8BOdpZp6MkTjhjldMWHa5kbuY32gtE/MB2Oo
	MCVcbXQl9LgWf23rHYa724rQXVXlQdLXPaeV0ET8M5bGEWT5u24OjU7R9I5p0Oz1+c9Fj5
	/0+yQMBlpv6n7LYoxgwtQOHZbSolsJWsnHNJVZhsNAONrv0n25/MspQ1k6DHzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770308041;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YIUry9ulEPJqzFPc7F31WKS7Dgo0bIDuJCWRBgf7Ls0=;
	b=Put2Y4d7N0ouKSsl1Iv2qKqbxuD2GKA6EVscBNy38Yo0qkUulrwLf0ij0/S3bjZ3sTN7Bu
	MoqzOEZqrmTrQtDQ==
From: "tip-bot2 for Petr Pavlu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] livepatch: Free klp_{object,func}_ext data
 after initialization
Cc: Petr Pavlu <petr.pavlu@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Miroslav Benes <mbenes@suse.cz>, Aaron Tomlin <atomlin@atomlin.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260123102825.3521961-3-petr.pavlu@suse.com>
References: <20260123102825.3521961-3-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177030804042.2495410.5473376925213943564.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8209-lists,linux-tip-commits=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linutronix.de:dkim,atomlin.com:email]
X-Rspamd-Queue-Id: 65AEAF512B
X-Rspamd-Action: no action

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     b525fcaf0a76507f152d58c6f9e5ef67b3ff552c
Gitweb:        https://git.kernel.org/tip/b525fcaf0a76507f152d58c6f9e5ef67b3f=
f552c
Author:        Petr Pavlu <petr.pavlu@suse.com>
AuthorDate:    Fri, 23 Jan 2026 11:26:57 +01:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Thu, 05 Feb 2026 08:00:45 -08:00

livepatch: Free klp_{object,func}_ext data after initialization

The klp_object_ext and klp_func_ext data, which are stored in the
__klp_objects and __klp_funcs sections, respectively, are not needed
after they are used to create the actual klp_object and klp_func
instances. This operation is implemented by the init function in
scripts/livepatch/init.c.

Prefix the two sections with ".init" so they are freed after the module
is initializated.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
Acked-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
Link: https://patch.msgid.link/20260123102825.3521961-3-petr.pavlu@suse.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/livepatch/init.c            |  2 +-
 scripts/module.lds.S                |  4 ++--
 tools/objtool/check.c               |  2 +-
 tools/objtool/include/objtool/klp.h | 10 +++++-----
 tools/objtool/klp-diff.c            |  2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/scripts/livepatch/init.c b/scripts/livepatch/init.c
index 9e315fc..638c95c 100644
--- a/scripts/livepatch/init.c
+++ b/scripts/livepatch/init.c
@@ -19,7 +19,7 @@ static int __init livepatch_mod_init(void)
 	unsigned int nr_objs;
 	int ret;
=20
-	obj_exts =3D klp_find_section_by_name(THIS_MODULE, "__klp_objects",
+	obj_exts =3D klp_find_section_by_name(THIS_MODULE, ".init.klp_objects",
 					    &obj_exts_sec_size);
 	nr_objs =3D obj_exts_sec_size / sizeof(*obj_exts);
 	if (!nr_objs) {
diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 383d19b..054ef99 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -34,8 +34,8 @@ SECTIONS {
=20
 	__patchable_function_entries : { *(__patchable_function_entries) }
=20
-	__klp_funcs		0: ALIGN(8) { KEEP(*(__klp_funcs)) }
-	__klp_objects		0: ALIGN(8) { KEEP(*(__klp_objects)) }
+	.init.klp_funcs		0 : ALIGN(8) { KEEP(*(.init.klp_funcs)) }
+	.init.klp_objects	0 : ALIGN(8) { KEEP(*(.init.klp_objects)) }
=20
 #ifdef CONFIG_ARCH_USES_CFI_TRAPS
 	__kcfi_traps		: { KEEP(*(.kcfi_traps)) }
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 3f79993..933868e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4761,7 +4761,7 @@ static int validate_ibt(struct objtool_file *file)
 		    !strcmp(sec->name, "__bug_table")			||
 		    !strcmp(sec->name, "__ex_table")			||
 		    !strcmp(sec->name, "__jump_table")			||
-		    !strcmp(sec->name, "__klp_funcs")			||
+		    !strcmp(sec->name, ".init.klp_funcs")		||
 		    !strcmp(sec->name, "__mcount_loc")			||
 		    !strcmp(sec->name, ".llvm.call-graph-profile")	||
 		    !strcmp(sec->name, ".llvm_bb_addr_map")		||
diff --git a/tools/objtool/include/objtool/klp.h b/tools/objtool/include/objt=
ool/klp.h
index ad830a7..e32e5e8 100644
--- a/tools/objtool/include/objtool/klp.h
+++ b/tools/objtool/include/objtool/klp.h
@@ -6,12 +6,12 @@
 #define SHN_LIVEPATCH		0xff20
=20
 /*
- * __klp_objects and __klp_funcs are created by klp diff and used by the pat=
ch
- * module init code to build the klp_patch, klp_object and klp_func structs
- * needed by the livepatch API.
+ * .init.klp_objects and .init.klp_funcs are created by klp diff and used by=
 the
+ * patch module init code to build the klp_patch, klp_object and klp_func
+ * structs needed by the livepatch API.
  */
-#define KLP_OBJECTS_SEC	"__klp_objects"
-#define KLP_FUNCS_SEC	"__klp_funcs"
+#define KLP_OBJECTS_SEC	".init.klp_objects"
+#define KLP_FUNCS_SEC	".init.klp_funcs"
=20
 /*
  * __klp_relocs is an intermediate section which are created by klp diff and
diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index d94531e..1e649a3 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -1436,7 +1436,7 @@ static int clone_special_sections(struct elfs *e)
 }
=20
 /*
- * Create __klp_objects and __klp_funcs sections which are intermediate
+ * Create .init.klp_objects and .init.klp_funcs sections which are intermedi=
ate
  * sections provided as input to the patch module's init code for building t=
he
  * klp_patch, klp_object and klp_func structs for the livepatch API.
  */

