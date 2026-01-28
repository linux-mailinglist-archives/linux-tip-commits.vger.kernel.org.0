Return-Path: <linux-tip-commits+bounces-8126-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLMJKwjNeWmOzgEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8126-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 09:47:04 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9519E55F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 09:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70C8C300D967
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 08:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C751225A33A;
	Wed, 28 Jan 2026 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GpwS59lI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6LvU1WT/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C3F2DB79B;
	Wed, 28 Jan 2026 08:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769589972; cv=none; b=jaUcr7gSV3Jg0J4SVAVWTQOnLKPcvGemrjJz4n6Zb3+PX/l5oPAyEXjaXAb6MPpporT+na/J6xNkKULMZu6W7cyyX1B2t/CMMNw9Qn+mEqvFQ/F+tvEd/dh4NBQ5nBPPpz4lmt+Gr6G8+0IeQJ8baMdAvQODOLruf154R8vQaoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769589972; c=relaxed/simple;
	bh=PhaRERJW5kQ1NGGLsZlgv1ogQXH7nv/fvqsAnA+q9Hw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=X6ueZYK63vVGnEtqKglJID54EDKyDza0VD/1YGsxVibsaTg+mWYVbQ0xtMHQ0wcMWqKEPSlhkCsbTaylpWMFCOnY4sH2EJsAbkiSitIYJBOjPM95ulSLueTGNEO1fhy2C9YcOyxf6wuBKuSY2jQs8VR7FroIjN2rUxOfjyRY9PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GpwS59lI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6LvU1WT/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Jan 2026 08:46:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769589969;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gvk7NsYaZqDYkdk17dd+5bdgp3hMZFEuPwuXrbm7q5k=;
	b=GpwS59lI6J+U+NmdT3qzsqyM8F2QL7yorbhNO5RASQOU2bAGOjYeurBq3JxTjn1wKNSnzp
	dTDi8WxKzq96eqNFMGMfuGEGsKbabURUh+wpV9fAVX0boaDICQDrWsHxaAFwEFqHDZFn0R
	CUtRS/gu5wj6syeEqhkEHn/laNeuNyME17X8A2QeKfg5q+A78iCtJwBdJoGVBWRh5FtD36
	VmlTJw9X9IwG9vzbsy3wsvnnbCkrkItW8D6Lv0AbkzOEramsldUcXs55cN85Stts6e36Ux
	WooudcXGB3xmvr7UJOwAtxTIOiVtHWVUiZJZGsauejnEJiw0+bDbDlFcrmCMhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769589969;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gvk7NsYaZqDYkdk17dd+5bdgp3hMZFEuPwuXrbm7q5k=;
	b=6LvU1WT/DTnWysL2necshL/lvPmhvaZkdDs46g3Dy1nnRWKxH2CiLc5xoZ83a5hNrRsvaZ
	pA7vwHd639wMecCA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] livepatch/klp-build: Fix klp-build vs
 CONFIG_MODULE_SRCVERSION_ALL
Cc: Song Liu <song@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <c41b6629e02775e4c1015259aa36065b3fe2f0f3.1769471792.git.jpoimboe@kernel.org>
References:
 <c41b6629e02775e4c1015259aa36065b3fe2f0f3.1769471792.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176958996819.510.12398407624380709658.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8126-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:dkim,msgid.link:url];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 0D9519E55F
X-Rspamd-Action: no action

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     78c268f3781e4b9706103def0cc011505e0c4332
Gitweb:        https://git.kernel.org/tip/78c268f3781e4b9706103def0cc011505e0=
c4332
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 26 Jan 2026 15:56:44 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 27 Jan 2026 08:20:51 -08:00

livepatch/klp-build: Fix klp-build vs CONFIG_MODULE_SRCVERSION_ALL

When building a patch to a single-file kernel module with
CONFIG_MODULE_SRCVERSION_ALL enabled, the klp-build module link fails in
modpost:

  Diffing objects
  drivers/md/raid0.o: changed function: raid0_run
  Building patch module: livepatch-0001-patch-raid0_run.ko
  drivers/md/raid0.c: No such file or directory
  ...

The problem here is that klp-build copied drivers/md/.raid0.o.cmd to the
module build directory, but it didn't also copy over the input source
file listed in the .cmd file:

  source_drivers/md/raid0.o :=3D drivers/md/raid0.c

So modpost dies due to the missing .c file which is needed for
calculating checksums for CONFIG_MODULE_SRCVERSION_ALL.

Instead of copying the original .cmd file, just create an empty one.
Modpost only requires that it exists.  The original object's build
dependencies are irrelevant for the frankenobjects used by klp-build.

Fixes: 24ebfcd65a87 ("livepatch/klp-build: Introduce klp-build script for gen=
erating livepatch modules")
Reported-by: Song Liu <song@kernel.org>
Tested-by: Song Liu <song@kernel.org>
Link: https://patch.msgid.link/c41b6629e02775e4c1015259aa36065b3fe2f0f3.17694=
71792.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/livepatch/klp-build | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index 8822721..a73515a 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -555,13 +555,11 @@ copy_orig_objects() {
 		local file_dir=3D"$(dirname "$file")"
 		local orig_file=3D"$ORIG_DIR/$rel_file"
 		local orig_dir=3D"$(dirname "$orig_file")"
-		local cmd_file=3D"$file_dir/.$(basename "$file").cmd"
=20
 		[[ ! -f "$file" ]] && die "missing $(basename "$file") for $_file"
=20
 		mkdir -p "$orig_dir"
 		cp -f "$file" "$orig_dir"
-		[[ -e "$cmd_file" ]] && cp -f "$cmd_file" "$orig_dir"
 	done
 	xtrace_restore
=20
@@ -740,15 +738,17 @@ build_patch_module() {
 		local orig_dir=3D"$(dirname "$orig_file")"
 		local kmod_file=3D"$KMOD_DIR/$rel_file"
 		local kmod_dir=3D"$(dirname "$kmod_file")"
-		local cmd_file=3D"$orig_dir/.$(basename "$file").cmd"
+		local cmd_file=3D"$kmod_dir/.$(basename "$file").cmd"
=20
 		mkdir -p "$kmod_dir"
 		cp -f "$file" "$kmod_dir"
-		[[ -e "$cmd_file" ]] && cp -f "$cmd_file" "$kmod_dir"
=20
 		# Tell kbuild this is a prebuilt object
 		cp -f "$file" "${kmod_file}_shipped"
=20
+		# Make modpost happy
+		touch "$cmd_file"
+
 		echo -n " $rel_file" >> "$makefile"
 	done
=20

