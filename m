Return-Path: <linux-tip-commits+bounces-6868-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E39BE28A6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A568501364
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725B431E106;
	Thu, 16 Oct 2025 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gGukQoiT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2+W+pmS2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3A03168F6;
	Thu, 16 Oct 2025 09:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608353; cv=none; b=rNgd/bkkCwIO9xq1EKAoLQq7wz79n+3Y8iIW7TQKdUE8nx5gapl+bFGiA7+xpRTlwDkOXO9yaiPtvqGyb9Y7kXTMubmg08j1YLqAb8yh49+X+xfgVjiaXVunT2b9/aA+sGacuE6CLVKUVJ8Cm2/riUVM3ioH2OIJjeGSbkHIcYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608353; c=relaxed/simple;
	bh=zL7+1BT90F7kSAszrTuV5Y/nV1pKV7Mct+2Y34H4siM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=d2/L/GOCh4d7Ejj4+PyApBvNYQbTeUcBxdGZJ+ecLuR38C9cv+Hyg2MuWzgwXV2zXbe5Pr3pWyh25QiMB63tuMmGuEuVx5smbeE8ghd2/niB2LauWBle2rDXrOALEyj0+qrFsSsF0Q5JUjnk8Wsdc/zGLOB9hrU782OgFsA452Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gGukQoiT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2+W+pmS2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608324;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=EUbJzihJ/OuBoq8CvzVKNBXux+ubOyVVi3rVQ4htSzI=;
	b=gGukQoiTNPslQfZz0B6wZB1cJBbAeKrucCkHm99PCVS8rgMCGoATLqJI7QDCMZ5+CD7r8z
	WXeIlRggcmsDpR4DL9VK3y/doCrivpvdTrq6z5bp7zugoEWvqLOaqBxyjN6Axzr/AERKGY
	Q6vLaoOnAFr4Vf11A2KpL2bjGXHkRkSl4vRvLQprz+UL75IPLdomkvdHhrL/EVBkYDsoHr
	TwEooFHY8e0ufeY6NpbYoY0eayeOgew8Q6v/BYPzNpLbKJWoQOB6OrsoZb864hE+Y7ByL8
	T4t+F1SSX6TG7PWmgU4UdNRQaLZ82WybmDMgq0LTfeGzAiVvbDwpeOvLpiP4bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608324;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=EUbJzihJ/OuBoq8CvzVKNBXux+ubOyVVi3rVQ4htSzI=;
	b=2+W+pmS2OGKONn/gsaLdMYNkQEhSFsByImkts8uJC9u9NTPc36vBHC8nM6RhHAV0FJihmG
	zzVyjQsbuQIcEQCw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] livepatch/klp-build: Add --debug option to show
 cloning decisions
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060832314.709179.9679901882768049441.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     2c2f0b8626917c48e4b12827d296a3c654612b90
Gitweb:        https://git.kernel.org/tip/2c2f0b8626917c48e4b12827d296a3c6546=
12b90
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:04:09 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:50:19 -07:00

livepatch/klp-build: Add --debug option to show cloning decisions

Add a --debug option which gets passed to "objtool klp diff" to enable
debug output related to cloning decisions.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/livepatch/klp-build | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index 01ed0b6..28ee259 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -20,7 +20,7 @@ set -o nounset
 # This helps keep execution in pipes so pipefail+errexit can catch errors.
 shopt -s lastpipe
=20
-unset SKIP_CLEANUP XTRACE
+unset DEBUG_CLONE SKIP_CLEANUP XTRACE
=20
 REPLACE=3D1
 SHORT_CIRCUIT=3D0
@@ -120,6 +120,7 @@ Options:
    -v, --verbose		Pass V=3D1 to kernel/module builds
=20
 Advanced Options:
+   -d, --debug			Show symbol/reloc cloning decisions
    -S, --short-circuit=3DSTEP	Start at build step (requires prior --keep-tmp)
 				   1|orig	Build original kernel (default)
 				   2|patched	Build patched kernel
@@ -140,8 +141,8 @@ process_args() {
 	local long
 	local args
=20
-	short=3D"hj:o:vS:T"
-	long=3D"help,jobs:,output:,no-replace,verbose,short-circuit:,keep-tmp"
+	short=3D"hj:o:vdS:T"
+	long=3D"help,jobs:,output:,no-replace,verbose,debug,short-circuit:,keep-tmp"
=20
 	args=3D$(getopt --options "$short" --longoptions "$long" -- "$@") || {
 		echo; usage; exit
@@ -174,6 +175,11 @@ process_args() {
 				VERBOSE=3D"V=3D1"
 				shift
 				;;
+			-d | --debug)
+				DEBUG_CLONE=3D1
+				keep_tmp=3D1
+				shift
+				;;
 			-S | --short-circuit)
 				[[ ! -d "$TMP_DIR" ]] && die "--short-circuit requires preserved klp-tmp=
 dir"
 				keep_tmp=3D1
@@ -596,6 +602,7 @@ copy_patched_objects() {
 diff_objects() {
 	local log=3D"$KLP_DIFF_LOG"
 	local files=3D()
+	local opts=3D()
=20
 	rm -rf "$DIFF_DIR"
 	mkdir -p "$DIFF_DIR"
@@ -603,6 +610,8 @@ diff_objects() {
 	find "$PATCHED_DIR" -type f -name "*.o" | mapfile -t files
 	[[ ${#files[@]} -eq 0 ]] && die "no changes detected"
=20
+	[[ -v DEBUG_CLONE ]] && opts=3D("--debug")
+
 	# Diff all changed objects
 	for file in "${files[@]}"; do
 		local rel_file=3D"${file#"$PATCHED_DIR"/}"
@@ -616,6 +625,7 @@ diff_objects() {
 		cmd=3D("$SRC/tools/objtool/objtool")
 		cmd+=3D("klp")
 		cmd+=3D("diff")
+		(( ${#opts[@]} > 0 )) && cmd+=3D("${opts[@]}")
 		cmd+=3D("$orig_file")
 		cmd+=3D("$patched_file")
 		cmd+=3D("$out_file")

