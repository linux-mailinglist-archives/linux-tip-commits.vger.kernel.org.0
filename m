Return-Path: <linux-tip-commits+bounces-6861-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 803D8BE2858
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9AB34FEE67
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D36631DDB6;
	Thu, 16 Oct 2025 09:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IfbhPDQb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Oa5vRKR+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC2531A7F5;
	Thu, 16 Oct 2025 09:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608331; cv=none; b=GeTZrjiOZ9/Ojl1FHRi6riC24ScYsfwxcbyFS1UmB9E+xuWc8pT8o839tg1lkF6480SbeUspS05+ZmbwJ2C/77PsfC1sFgvBJTVspB7svTVOGALuvUtQOJtigIJJcroNHK1gIHvVirQFFYqj7uRxWO/I2J81GdZksIUBX2yoUW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608331; c=relaxed/simple;
	bh=YpXUw8wuiZmhuV8Mb3YFLaFgNDL+/7IqJ+hVUybuFy0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=m//R6w7uGT8NomjFfJfXaDtMcvizQwzOYvz5uZhfQ/Zkwe6n2V7Nt/J44ONFy2rX7H4wKehjaBZTIOxN2P1P0jlpcTXjii26yhAQ5fRDMEukZ/N03bemp9kyon+9gjV23lxG7IRzBkfv0I8TxHqst9BbrkyzkZeDs3m7FKQdqnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IfbhPDQb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Oa5vRKR+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608323;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=DHlInRtUVRTKQVKJKY1JZJdVYWfaJUIyRbbP4Sz05vY=;
	b=IfbhPDQbcDKib4B2KmRGgLESXOeLI4Wd+6vyP/J12F5KX7cnKZMkAPRi575KQo/LP5x08G
	c6Y0gQlYctZmvgNc73FZxRe/INaW6uTxo32EhPwfkkOhCQ33SOhX680emi8kk3as6hR8sU
	R3YTfIaqTWNdD9CVXWhJSpwf79tUk8LoNOjtZLB1JEgEql76JbuCVHX3po4OT3Diu4Fhbk
	2RbBaQLmF7dmUlgbvI78HYHd7x/8Lg7KZaEjEsHjZZSBSg2LHAhayNVvr6bJ5cB9sbfg1K
	A2NkpRFOo1xQmm2ni94vqh7SXX9pO6jQuzziGObEp4usmihC4mEed1Q5R0RMdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608323;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=DHlInRtUVRTKQVKJKY1JZJdVYWfaJUIyRbbP4Sz05vY=;
	b=Oa5vRKR+4kuww1FsDEnBZH5W2QFazz+Ep+WsqZnAmte2+osxPVfjCgiysv4uFrCpepAdnW
	FeG7srFbsl8HKfCg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] livepatch/klp-build: Add --show-first-changed
 option to show function divergence
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060832182.709179.10666029769586722254.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     78be9facfb5e711e5284ef1856401ea909eceeb2
Gitweb:        https://git.kernel.org/tip/78be9facfb5e711e5284ef1856401ea909e=
ceeb2
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:04:10 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:50:19 -07:00

livepatch/klp-build: Add --show-first-changed option to show function diverge=
nce

Add a --show-first-changed option to identify where changed functions
begin to diverge:

  - Parse 'objtool klp diff' output to find changed functions.

  - Run objtool again on each object with --debug-checksum=3D<funcs>.

  - Diff the per-instruction checksum debug output to locate the first
    differing instruction.

This can be useful for quickly determining where and why a function
changed.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/livepatch/klp-build | 82 ++++++++++++++++++++++++++++++++++--
 1 file changed, 78 insertions(+), 4 deletions(-)

diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
index 28ee259..881e052 100755
--- a/scripts/livepatch/klp-build
+++ b/scripts/livepatch/klp-build
@@ -20,7 +20,7 @@ set -o nounset
 # This helps keep execution in pipes so pipefail+errexit can catch errors.
 shopt -s lastpipe
=20
-unset DEBUG_CLONE SKIP_CLEANUP XTRACE
+unset DEBUG_CLONE DIFF_CHECKSUM SKIP_CLEANUP XTRACE
=20
 REPLACE=3D1
 SHORT_CIRCUIT=3D0
@@ -114,6 +114,7 @@ Usage: $SCRIPT [OPTIONS] PATCH_FILE(s)
 Generate a livepatch module.
=20
 Options:
+   -f, --show-first-changed	Show address of first changed instruction
    -j, --jobs=3D<jobs>		Build jobs to run simultaneously [default: $JOBS]
    -o, --output=3D<file.ko>	Output file [default: livepatch-<patch-name>.ko]
        --no-replace		Disable livepatch atomic replace
@@ -141,8 +142,8 @@ process_args() {
 	local long
 	local args
=20
-	short=3D"hj:o:vdS:T"
-	long=3D"help,jobs:,output:,no-replace,verbose,debug,short-circuit:,keep-tmp"
+	short=3D"hfj:o:vdS:T"
+	long=3D"help,show-first-changed,jobs:,output:,no-replace,verbose,debug,shor=
t-circuit:,keep-tmp"
=20
 	args=3D$(getopt --options "$short" --longoptions "$long" -- "$@") || {
 		echo; usage; exit
@@ -155,6 +156,10 @@ process_args() {
 				usage
 				exit 0
 				;;
+			-f | --show-first-changed)
+				DIFF_CHECKSUM=3D1
+				shift
+				;;
 			-j | --jobs)
 				JOBS=3D"$2"
 				shift 2
@@ -618,6 +623,7 @@ diff_objects() {
 		local orig_file=3D"$rel_file"
 		local patched_file=3D"$PATCHED_DIR/$rel_file"
 		local out_file=3D"$DIFF_DIR/$rel_file"
+		local filter=3D()
 		local cmd=3D()
=20
 		mkdir -p "$(dirname "$out_file")"
@@ -630,16 +636,80 @@ diff_objects() {
 		cmd+=3D("$patched_file")
 		cmd+=3D("$out_file")
=20
+		if [[ -v DIFF_CHECKSUM ]]; then
+			filter=3D("grep0")
+			filter+=3D("-Ev")
+			filter+=3D("DEBUG: .*checksum: ")
+		else
+			filter=3D("cat")
+		fi
+
 		(
 			cd "$ORIG_DIR"
 			"${cmd[@]}"							\
 				1> >(tee -a "$log")					\
-				2> >(tee -a "$log" >&2) ||				\
+				2> >(tee -a "$log" | "${filter[@]}" >&2) ||		\
 				die "objtool klp diff failed"
 		)
 	done
 }
=20
+# For each changed object, run objtool with --debug-checksum to get the
+# per-instruction checksums, and then diff those to find the first changed
+# instruction for each function.
+diff_checksums() {
+	local orig_log=3D"$ORIG_DIR/checksum.log"
+	local patched_log=3D"$PATCHED_DIR/checksum.log"
+	local -A funcs
+	local cmd=3D()
+	local line
+	local file
+	local func
+
+	gawk '/\.o: changed function: / {
+		sub(/:$/, "", $1)
+		print $1, $NF
+	}' "$KLP_DIFF_LOG" | mapfile -t lines
+
+	for line in "${lines[@]}"; do
+		read -r file func <<< "$line"
+		if [[ ! -v funcs["$file"] ]]; then
+			funcs["$file"]=3D"$func"
+		else
+			funcs["$file"]+=3D" $func"
+		fi
+	done
+
+	cmd=3D("$SRC/tools/objtool/objtool")
+	cmd+=3D("--checksum")
+	cmd+=3D("--link")
+	cmd+=3D("--dry-run")
+
+	for file in "${!funcs[@]}"; do
+		local opt=3D"--debug-checksum=3D${funcs[$file]// /,}"
+
+		(
+			cd "$ORIG_DIR"
+			"${cmd[@]}" "$opt" "$file" &> "$orig_log" || \
+				( cat "$orig_log" >&2; die "objtool --debug-checksum failed" )
+
+			cd "$PATCHED_DIR"
+			"${cmd[@]}" "$opt" "$file" &> "$patched_log" ||	\
+				( cat "$patched_log" >&2; die "objtool --debug-checksum failed" )
+		)
+
+		for func in ${funcs[$file]}; do
+			diff <( grep0 -E "^DEBUG: .*checksum: $func " "$orig_log"    | sed "s|$OR=
IG_DIR/||")	\
+			     <( grep0 -E "^DEBUG: .*checksum: $func " "$patched_log" | sed "s|$PA=
TCHED_DIR/||")	\
+				| gawk '/^< DEBUG: / {
+					gsub(/:/, "")
+					printf "%s: %s: %s\n", $3, $5, $6
+					exit
+			}' || true
+		done
+	done
+}
+
 # Build and post-process livepatch module in $KMOD_DIR
 build_patch_module() {
 	local makefile=3D"$KMOD_DIR/Kbuild"
@@ -743,6 +813,10 @@ fi
 if (( SHORT_CIRCUIT <=3D 3 )); then
 	status "Diffing objects"
 	diff_objects
+	if [[ -v DIFF_CHECKSUM ]]; then
+		status "Finding first changed instructions"
+		diff_checksums
+	fi
 fi
=20
 if (( SHORT_CIRCUIT <=3D 4 )); then

