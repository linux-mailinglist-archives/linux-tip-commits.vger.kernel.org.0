Return-Path: <linux-tip-commits+bounces-6864-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 84769BE2878
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 208A64FEDE8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA10320A0A;
	Thu, 16 Oct 2025 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n4kp1V6u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WnogvACV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B7431A7E3;
	Thu, 16 Oct 2025 09:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608338; cv=none; b=Wyvy5Prxw9hLLqxijVj/C1oeBF0Pq3JPnRWhSz0KH5MVms58+ltqAsvS4dlyXy20j6qWmMHC5FAiREf4HIg/NoybqgjdCbl80yxytR0XNroguK083Wtsww59/fl6oq9K1kXVcWpQV8j1uMQ9MMw/BufS2eWbZG0L8zVUNj5f0NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608338; c=relaxed/simple;
	bh=KJ8p3K9XMAE4P6y4f1zFtHOubr6e640+Lpy0eqOzQA4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=kQN+JEwlvpU6gv1Zux92aRme6odZ7MeahGhC0bt0JXZt33HFN++FTX9wkv6iLs95qXvK8LWUcaWUI8in7ZfWv8vml+lzyDR1xiAwKWELbCbMCgvqOH16JTUJ8pKr6E9FGNNHOtNlWNCBsX5aCoOkYV8FcG5mmQheCSpAHsnEhRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n4kp1V6u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WnogvACV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608326;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=JLy7fXAS5hMQ54bgCsHTTuPCkVk7MAdurzKjZ4Ye8sU=;
	b=n4kp1V6uyGzDZ8LxNr3uRiK2Z29NwMh0NIRHNup4kByV4qICzJRFo0VfVx/LzuHOeDmI6b
	Knl4urvKaPLFHkVLUYE9+LAt/2SNR08TKkbOdBqYDxi8kBTxkpRVUZgh85IW0moYHDaSqJ
	OqWvcTm8Yf6+XNvlMRDEbEClfUXIe+SAR/zExU0Zv5IuQwT5D95SWJaHfuf1wrv1o/71DD
	Fw1b8wYDV2o3JemAJF6muFcmLb56Z09t5CDEUKLfccC2qnhTDm1esvuHPI3BOnMovBt+Xt
	qsPgRUO+kpaJcwRVIZ5ks3SV3Y9qa+JZ/n5WI8TkjG+MOW7Glu3XbUSQER5TWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608326;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=JLy7fXAS5hMQ54bgCsHTTuPCkVk7MAdurzKjZ4Ye8sU=;
	b=WnogvACVx9ecDgZ3eo40AXoDBqagpF1LN6WQHL8iNbnnsmyYeaalWFKe3RHRGREkjvwByk
	Eh63uKwLoBK4byBQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] livepatch/klp-build: Introduce klp-build script
 for generating livepatch modules
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060832459.709179.7771066400421091966.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     24ebfcd65a871df4555b98c49c9ed9a92f146113
Gitweb:        https://git.kernel.org/tip/24ebfcd65a871df4555b98c49c9ed9a92f1=
46113
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:04:08 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:50:19 -07:00

livepatch/klp-build: Introduce klp-build script for generating livepatch modu=
les

Add a klp-build script which automates the generation of a livepatch
module from a source .patch file by performing the following steps:

  - Builds an original kernel with -function-sections and
    -fdata-sections, plus objtool function checksumming.

  - Applies the .patch file and rebuilds the kernel using the same
    options.

  - Runs 'objtool klp diff' to detect changed functions and generate
    intermediate binary diff objects.

  - Builds a kernel module which links the diff objects with some
    livepatch module init code (scripts/livepatch/init.c).

  - Finalizes the livepatch module (aka work around linker wreckage)
    using 'objtool klp post-link'.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/Makefile.lib              |   1 +-
 scripts/livepatch/fix-patch-lines |   2 +-
 scripts/livepatch/klp-build       | 743 +++++++++++++++++++++++++++++-
 tools/objtool/klp-diff.c          |   6 +-
 4 files changed, 749 insertions(+), 3 deletions(-)
 create mode 100755 scripts/livepatch/klp-build

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 28a1c08..f4b3391 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -173,6 +173,7 @@ ifdef CONFIG_OBJTOOL
=20
 objtool :=3D $(objtree)/tools/objtool/objtool
=20
+objtool-args-$(CONFIG_KLP_BUILD)			+=3D --checksum
 objtool-args-$(CONFIG_HAVE_JUMP_LABEL_HACK)		+=3D --hacks=3Djump_label
 objtool-args-$(CONFIG_HAVE_NOINSTR_HACK)		+=3D --hacks=3Dnoinstr
 objtool-args-$(CONFIG_MITIGATION_CALL_DEPTH_TRACKING)	+=3D --hacks=3Dskylake
diff --git a/scripts/livepatch/fix-patch-lines b/scripts/livepatch/fix-patch-=
lines
index 73c5e3d..fa7d4f6 100755
--- a/scripts/livepatch/fix-patch-lines
+++ b/scripts/livepatch/fix-patch-lines
@@ -23,7 +23,7 @@ BEGIN {
=20
 	in_hunk =3D 1
=20
-	# for @@ -1,3 +1,4 @@:
+	# @@ -1,3 +1,4 @@:
 	#   1: line number in old file
 	#   3: how many lines the hunk covers in old file
 	#   1: line number in new file
diff --git a/scripts/livepatch/klp-build b/scripts/livepatch/klp-build
new file mode 100755
index 0000000..01ed0b6
--- /dev/null
+++ b/scripts/livepatch/klp-build
@@ -0,0 +1,743 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Build a livepatch module
+
+# shellcheck disable=3DSC1090,SC2155
+
+if (( BASH_VERSINFO[0]  < 4 || \
+     (BASH_VERSINFO[0] =3D=3D 4 && BASH_VERSINFO[1] < 4) )); then
+		echo "error: this script requires bash 4.4+" >&2
+	exit 1
+fi
+
+set -o errexit
+set -o errtrace
+set -o pipefail
+set -o nounset
+
+# Allow doing 'cmd | mapfile -t array' instead of 'mapfile -t array < <(cmd)=
'.
+# This helps keep execution in pipes so pipefail+errexit can catch errors.
+shopt -s lastpipe
+
+unset SKIP_CLEANUP XTRACE
+
+REPLACE=3D1
+SHORT_CIRCUIT=3D0
+JOBS=3D"$(getconf _NPROCESSORS_ONLN)"
+VERBOSE=3D"-s"
+shopt -o xtrace | grep -q 'on' && XTRACE=3D1
+
+# Avoid removing the previous $TMP_DIR until args have been fully processed.
+KEEP_TMP=3D1
+
+SCRIPT=3D"$(basename "$0")"
+SCRIPT_DIR=3D"$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
+FIX_PATCH_LINES=3D"$SCRIPT_DIR/fix-patch-lines"
+
+SRC=3D"$(pwd)"
+OBJ=3D"$(pwd)"
+
+CONFIG=3D"$OBJ/.config"
+TMP_DIR=3D"$OBJ/klp-tmp"
+
+ORIG_DIR=3D"$TMP_DIR/orig"
+PATCHED_DIR=3D"$TMP_DIR/patched"
+DIFF_DIR=3D"$TMP_DIR/diff"
+KMOD_DIR=3D"$TMP_DIR/kmod"
+
+STASH_DIR=3D"$TMP_DIR/stash"
+TIMESTAMP=3D"$TMP_DIR/timestamp"
+PATCH_TMP_DIR=3D"$TMP_DIR/tmp"
+
+KLP_DIFF_LOG=3D"$DIFF_DIR/diff.log"
+
+grep0() {
+	command grep "$@" || true
+}
+
+status() {
+	echo "$*"
+}
+
+warn() {
+	echo "error: $SCRIPT: $*" >&2
+}
+
+die() {
+	warn "$@"
+	exit 1
+}
+
+declare -a STASHED_FILES
+
+stash_file() {
+	local file=3D"$1"
+	local rel_file=3D"${file#"$SRC"/}"
+
+	[[ ! -e "$file" ]] && die "no file to stash: $file"
+
+	mkdir -p "$STASH_DIR/$(dirname "$rel_file")"
+	cp -f "$file" "$STASH_DIR/$rel_file"
+
+	STASHED_FILES+=3D("$rel_file")
+}
+
+restore_files() {
+	local file
+
+	for file in "${STASHED_FILES[@]}"; do
+		mv -f "$STASH_DIR/$file" "$SRC/$file" || warn "can't restore file: $file"
+	done
+
+	STASHED_FILES=3D()
+}
+
+cleanup() {
+	set +o nounset
+	revert_patches "--recount"
+	restore_files
+	[[ "$KEEP_TMP" -eq 0 ]] && rm -rf "$TMP_DIR"
+	return 0
+}
+
+trap_err() {
+	warn "line ${BASH_LINENO[0]}: '$BASH_COMMAND'"
+}
+
+trap cleanup  EXIT INT TERM HUP
+trap trap_err ERR
+
+__usage() {
+	cat <<EOF
+Usage: $SCRIPT [OPTIONS] PATCH_FILE(s)
+Generate a livepatch module.
+
+Options:
+   -j, --jobs=3D<jobs>		Build jobs to run simultaneously [default: $JOBS]
+   -o, --output=3D<file.ko>	Output file [default: livepatch-<patch-name>.ko]
+       --no-replace		Disable livepatch atomic replace
+   -v, --verbose		Pass V=3D1 to kernel/module builds
+
+Advanced Options:
+   -S, --short-circuit=3DSTEP	Start at build step (requires prior --keep-tmp)
+				   1|orig	Build original kernel (default)
+				   2|patched	Build patched kernel
+				   3|diff	Diff objects
+				   4|kmod	Build patch module
+   -T, --keep-tmp		Preserve tmp dir on exit
+
+EOF
+}
+
+usage() {
+	__usage >&2
+}
+
+process_args() {
+	local keep_tmp=3D0
+	local short
+	local long
+	local args
+
+	short=3D"hj:o:vS:T"
+	long=3D"help,jobs:,output:,no-replace,verbose,short-circuit:,keep-tmp"
+
+	args=3D$(getopt --options "$short" --longoptions "$long" -- "$@") || {
+		echo; usage; exit
+	}
+	eval set -- "$args"
+
+	while true; do
+		case "$1" in
+			-h | --help)
+				usage
+				exit 0
+				;;
+			-j | --jobs)
+				JOBS=3D"$2"
+				shift 2
+				;;
+			-o | --output)
+				[[ "$2" !=3D *.ko ]] && die "output filename should end with .ko"
+				OUTFILE=3D"$2"
+				NAME=3D"$(basename "$OUTFILE")"
+				NAME=3D"${NAME%.ko}"
+				NAME=3D"$(module_name_string "$NAME")"
+				shift 2
+				;;
+			--no-replace)
+				REPLACE=3D0
+				shift
+				;;
+			-v | --verbose)
+				VERBOSE=3D"V=3D1"
+				shift
+				;;
+			-S | --short-circuit)
+				[[ ! -d "$TMP_DIR" ]] && die "--short-circuit requires preserved klp-tmp=
 dir"
+				keep_tmp=3D1
+				case "$2" in
+					1 | orig)	SHORT_CIRCUIT=3D1; ;;
+					2 | patched)	SHORT_CIRCUIT=3D2; ;;
+					3 | diff)	SHORT_CIRCUIT=3D3; ;;
+					4 | mod)	SHORT_CIRCUIT=3D4; ;;
+					*)		die "invalid short-circuit step '$2'" ;;
+				esac
+				shift 2
+				;;
+			-T | --keep-tmp)
+				keep_tmp=3D1
+				shift
+				;;
+			--)
+				shift
+				break
+				;;
+			*)
+				usage
+				exit 1
+				;;
+		esac
+	done
+
+	if [[ $# -eq 0 ]]; then
+		usage
+		exit 1
+	fi
+
+	KEEP_TMP=3D"$keep_tmp"
+	PATCHES=3D("$@")
+}
+
+# temporarily disable xtrace for especially verbose code
+xtrace_save() {
+	[[ -v XTRACE ]] && set +x
+	return 0
+}
+
+xtrace_restore() {
+	[[ -v XTRACE ]] && set -x
+	return 0
+}
+
+validate_config() {
+	xtrace_save "reading .config"
+	source "$CONFIG" || die "no .config file in $(dirname "$CONFIG")"
+	xtrace_restore
+
+	[[ -v CONFIG_LIVEPATCH ]] ||			\
+		die "CONFIG_LIVEPATCH not enabled"
+
+	[[ -v CONFIG_KLP_BUILD ]] ||			\
+		die "CONFIG_KLP_BUILD not enabled"
+
+	[[ -v CONFIG_GCC_PLUGIN_LATENT_ENTROPY ]] &&	\
+		die "kernel option 'CONFIG_GCC_PLUGIN_LATENT_ENTROPY' not supported"
+
+	[[ -v CONFIG_GCC_PLUGIN_RANDSTRUCT ]] &&	\
+		die "kernel option 'CONFIG_GCC_PLUGIN_RANDSTRUCT' not supported"
+
+	return 0
+}
+
+# Only allow alphanumerics and '_' and '-' in the module name.  Everything e=
lse
+# is replaced with '-'.  Also truncate to 55 chars so the full name + NUL
+# terminator fits in the kernel's 56-byte module name array.
+module_name_string() {
+	echo "${1//[^a-zA-Z0-9_-]/-}" | cut -c 1-55
+}
+
+# If the module name wasn't specified on the cmdline with --output, give it a
+# name based on the patch name.
+set_module_name() {
+	[[ -v NAME ]] && return 0
+
+	if [[ "${#PATCHES[@]}" -eq 1 ]]; then
+		NAME=3D"$(basename "${PATCHES[0]}")"
+		NAME=3D"${NAME%.*}"
+	else
+		NAME=3D"patch"
+	fi
+
+	NAME=3D"livepatch-$NAME"
+	NAME=3D"$(module_name_string "$NAME")"
+
+	OUTFILE=3D"$NAME.ko"
+}
+
+# Hardcode the value printed by the localversion script to prevent patch
+# application from appending it with '+' due to a dirty git working tree.
+set_kernelversion() {
+	local file=3D"$SRC/scripts/setlocalversion"
+	local localversion
+
+	stash_file "$file"
+
+	localversion=3D"$(cd "$SRC" && make --no-print-directory kernelversion)"
+	localversion=3D"$(cd "$SRC" && KERNELVERSION=3D"$localversion" ./scripts/se=
tlocalversion)"
+	[[ -z "$localversion" ]] && die "setlocalversion failed"
+
+	sed -i "2i echo $localversion; exit 0" scripts/setlocalversion
+}
+
+get_patch_files() {
+	local patch=3D"$1"
+
+	grep0 -E '^(--- |\+\+\+ )' "$patch"			\
+		| gawk '{print $2}'				\
+		| sed 's|^[^/]*/||'				\
+		| sort -u
+}
+
+# Make sure git re-stats the changed files
+git_refresh() {
+	local patch=3D"$1"
+	local files=3D()
+
+	[[ ! -e "$SRC/.git" ]] && return
+
+	get_patch_files "$patch" | mapfile -t files
+
+	(
+		cd "$SRC"
+		git update-index -q --refresh -- "${files[@]}"
+	)
+}
+
+check_unsupported_patches() {
+	local patch
+
+	for patch in "${PATCHES[@]}"; do
+		local files=3D()
+
+		get_patch_files "$patch" | mapfile -t files
+
+		for file in "${files[@]}"; do
+			case "$file" in
+				lib/*|*.S)
+					die "unsupported patch to $file"
+					;;
+			esac
+		done
+	done
+}
+
+apply_patch() {
+	local patch=3D"$1"
+	shift
+	local extra_args=3D("$@")
+
+	[[ ! -f "$patch" ]] && die "$patch doesn't exist"
+
+	(
+		cd "$SRC"
+
+		# The sed strips the version signature from 'git format-patch',
+		# otherwise 'git apply --recount' warns.
+		sed -n '/^-- /q;p' "$patch" |
+			git apply "${extra_args[@]}"
+	)
+
+	APPLIED_PATCHES+=3D("$patch")
+}
+
+revert_patch() {
+	local patch=3D"$1"
+	shift
+	local extra_args=3D("$@")
+	local tmp=3D()
+
+	(
+		cd "$SRC"
+
+		sed -n '/^-- /q;p' "$patch" |
+			git apply --reverse "${extra_args[@]}"
+	)
+	git_refresh "$patch"
+
+	for p in "${APPLIED_PATCHES[@]}"; do
+		[[ "$p" =3D=3D "$patch" ]] && continue
+		tmp+=3D("$p")
+	done
+
+	APPLIED_PATCHES=3D("${tmp[@]}")
+}
+
+apply_patches() {
+	local patch
+
+	for patch in "${PATCHES[@]}"; do
+		apply_patch "$patch"
+	done
+}
+
+revert_patches() {
+	local extra_args=3D("$@")
+	local patches=3D("${APPLIED_PATCHES[@]}")
+
+	for (( i=3D${#patches[@]}-1 ; i>=3D0 ; i-- )) ; do
+		revert_patch "${patches[$i]}" "${extra_args[@]}"
+	done
+
+	APPLIED_PATCHES=3D()
+}
+
+validate_patches() {
+	check_unsupported_patches
+	apply_patches
+	revert_patches
+}
+
+do_init() {
+	# We're not yet smart enough to handle anything other than in-tree
+	# builds in pwd.
+	[[ ! "$SRC" -ef "$SCRIPT_DIR/../.." ]] && die "please run from the kernel r=
oot directory"
+	[[ ! "$OBJ" -ef "$SCRIPT_DIR/../.." ]] && die "please run from the kernel r=
oot directory"
+
+	(( SHORT_CIRCUIT <=3D 1 )) && rm -rf "$TMP_DIR"
+	mkdir -p "$TMP_DIR"
+
+	APPLIED_PATCHES=3D()
+
+	[[ -x "$FIX_PATCH_LINES" ]] || die "can't find fix-patch-lines"
+
+	validate_config
+	set_module_name
+	set_kernelversion
+}
+
+# Refresh the patch hunk headers, specifically the line numbers and counts.
+refresh_patch() {
+	local patch=3D"$1"
+	local tmpdir=3D"$PATCH_TMP_DIR"
+	local files=3D()
+
+	rm -rf "$tmpdir"
+	mkdir -p "$tmpdir/a"
+	mkdir -p "$tmpdir/b"
+
+	# Get all source files affected by the patch
+	get_patch_files "$patch" | mapfile -t files
+
+	# Copy orig source files to 'a'
+	( cd "$SRC" && echo "${files[@]}" | xargs cp --parents --target-directory=
=3D"$tmpdir/a" )
+
+	# Copy patched source files to 'b'
+	apply_patch "$patch" --recount
+	( cd "$SRC" && echo "${files[@]}" | xargs cp --parents --target-directory=
=3D"$tmpdir/b" )
+	revert_patch "$patch" --recount
+
+	# Diff 'a' and 'b' to make a clean patch
+	( cd "$tmpdir" && git diff --no-index --no-prefix a b > "$patch" ) || true
+}
+
+# Copy the patches to a temporary directory, fix their lines so as not to
+# affect the __LINE__ macro for otherwise unchanged functions further down t=
he
+# file, and update $PATCHES to point to the fixed patches.
+fix_patches() {
+	local idx
+	local i
+
+	rm -f "$TMP_DIR"/*.patch
+
+	idx=3D0001
+	for i in "${!PATCHES[@]}"; do
+		local old_patch=3D"${PATCHES[$i]}"
+		local tmp_patch=3D"$TMP_DIR/tmp.patch"
+		local patch=3D"${PATCHES[$i]}"
+		local new_patch
+
+		new_patch=3D"$TMP_DIR/$idx-fixed-$(basename "$patch")"
+
+		cp -f "$old_patch" "$tmp_patch"
+		refresh_patch "$tmp_patch"
+		"$FIX_PATCH_LINES" "$tmp_patch" > "$new_patch"
+		refresh_patch "$new_patch"
+
+		PATCHES[i]=3D"$new_patch"
+
+		rm -f "$tmp_patch"
+		idx=3D$(printf "%04d" $(( 10#$idx + 1 )))
+	done
+}
+
+clean_kernel() {
+	local cmd=3D()
+
+	cmd=3D("make")
+	cmd+=3D("--silent")
+	cmd+=3D("-j$JOBS")
+	cmd+=3D("clean")
+
+	(
+		cd "$SRC"
+		"${cmd[@]}"
+	)
+}
+
+build_kernel() {
+	local log=3D"$TMP_DIR/build.log"
+	local cmd=3D()
+
+	cmd=3D("make")
+
+	# When a patch to a kernel module references a newly created unexported
+	# symbol which lives in vmlinux or another kernel module, the patched
+	# kernel build fails with the following error:
+	#
+	#   ERROR: modpost: "klp_string" [fs/xfs/xfs.ko] undefined!
+	#
+	# The undefined symbols are working as designed in that case.  They get
+	# resolved later when the livepatch module build link pulls all the
+	# disparate objects together into the same kernel module.
+	#
+	# It would be good to have a way to tell modpost to skip checking for
+	# undefined symbols altogether.  For now, just convert the error to a
+	# warning with KBUILD_MODPOST_WARN, and grep out the warning to avoid
+	# confusing the user.
+	#
+	cmd+=3D("KBUILD_MODPOST_WARN=3D1")
+
+	cmd+=3D("$VERBOSE")
+	cmd+=3D("-j$JOBS")
+	cmd+=3D("KCFLAGS=3D-ffunction-sections -fdata-sections")
+	cmd+=3D("vmlinux")
+	cmd+=3D("modules")
+
+	(
+		cd "$SRC"
+		"${cmd[@]}"							\
+			1> >(tee -a "$log")					\
+			2> >(tee -a "$log" | grep0 -v "modpost.*undefined!" >&2)
+	)
+}
+
+find_objects() {
+	local opts=3D("$@")
+
+	# Find root-level vmlinux.o and non-root-level .ko files,
+	# excluding klp-tmp/ and .git/
+	find "$OBJ" \( -path "$TMP_DIR" -o -path "$OBJ/.git" -o	-regex "$OBJ/[^/][^=
/]*\.ko" \) -prune -o \
+		    -type f "${opts[@]}"				\
+		    \( -name "*.ko" -o -path "$OBJ/vmlinux.o" \)	\
+		    -printf '%P\n'
+}
+
+# Copy all .o archives to $ORIG_DIR
+copy_orig_objects() {
+	local files=3D()
+
+	rm -rf "$ORIG_DIR"
+	mkdir -p "$ORIG_DIR"
+
+	find_objects | mapfile -t files
+
+	xtrace_save "copying orig objects"
+	for _file in "${files[@]}"; do
+		local rel_file=3D"${_file/.ko/.o}"
+		local file=3D"$OBJ/$rel_file"
+		local file_dir=3D"$(dirname "$file")"
+		local orig_file=3D"$ORIG_DIR/$rel_file"
+		local orig_dir=3D"$(dirname "$orig_file")"
+		local cmd_file=3D"$file_dir/.$(basename "$file").cmd"
+
+		[[ ! -f "$file" ]] && die "missing $(basename "$file") for $_file"
+
+		mkdir -p "$orig_dir"
+		cp -f "$file" "$orig_dir"
+		[[ -e "$cmd_file" ]] && cp -f "$cmd_file" "$orig_dir"
+	done
+	xtrace_restore
+
+	mv -f "$TMP_DIR/build.log" "$ORIG_DIR"
+	touch "$TIMESTAMP"
+}
+
+# Copy all changed objects to $PATCHED_DIR
+copy_patched_objects() {
+	local files=3D()
+	local opts=3D()
+	local found=3D0
+
+	rm -rf "$PATCHED_DIR"
+	mkdir -p "$PATCHED_DIR"
+
+	# Note this doesn't work with some configs, thus the 'cmp' below.
+	opts=3D("-newer")
+	opts+=3D("$TIMESTAMP")
+
+	find_objects "${opts[@]}" | mapfile -t files
+
+	xtrace_save "copying changed objects"
+	for _file in "${files[@]}"; do
+		local rel_file=3D"${_file/.ko/.o}"
+		local file=3D"$OBJ/$rel_file"
+		local orig_file=3D"$ORIG_DIR/$rel_file"
+		local patched_file=3D"$PATCHED_DIR/$rel_file"
+		local patched_dir=3D"$(dirname "$patched_file")"
+
+		[[ ! -f "$file" ]] && die "missing $(basename "$file") for $_file"
+
+		cmp -s "$orig_file" "$file" && continue
+
+		mkdir -p "$patched_dir"
+		cp -f "$file" "$patched_dir"
+		found=3D1
+	done
+	xtrace_restore
+
+	(( found =3D=3D 0 )) && die "no changes detected"
+
+	mv -f "$TMP_DIR/build.log" "$PATCHED_DIR"
+}
+
+# Diff changed objects, writing output object to $DIFF_DIR
+diff_objects() {
+	local log=3D"$KLP_DIFF_LOG"
+	local files=3D()
+
+	rm -rf "$DIFF_DIR"
+	mkdir -p "$DIFF_DIR"
+
+	find "$PATCHED_DIR" -type f -name "*.o" | mapfile -t files
+	[[ ${#files[@]} -eq 0 ]] && die "no changes detected"
+
+	# Diff all changed objects
+	for file in "${files[@]}"; do
+		local rel_file=3D"${file#"$PATCHED_DIR"/}"
+		local orig_file=3D"$rel_file"
+		local patched_file=3D"$PATCHED_DIR/$rel_file"
+		local out_file=3D"$DIFF_DIR/$rel_file"
+		local cmd=3D()
+
+		mkdir -p "$(dirname "$out_file")"
+
+		cmd=3D("$SRC/tools/objtool/objtool")
+		cmd+=3D("klp")
+		cmd+=3D("diff")
+		cmd+=3D("$orig_file")
+		cmd+=3D("$patched_file")
+		cmd+=3D("$out_file")
+
+		(
+			cd "$ORIG_DIR"
+			"${cmd[@]}"							\
+				1> >(tee -a "$log")					\
+				2> >(tee -a "$log" >&2) ||				\
+				die "objtool klp diff failed"
+		)
+	done
+}
+
+# Build and post-process livepatch module in $KMOD_DIR
+build_patch_module() {
+	local makefile=3D"$KMOD_DIR/Kbuild"
+	local log=3D"$KMOD_DIR/build.log"
+	local kmod_file
+	local cflags=3D()
+	local files=3D()
+	local cmd=3D()
+
+	rm -rf "$KMOD_DIR"
+	mkdir -p "$KMOD_DIR"
+
+	cp -f "$SRC/scripts/livepatch/init.c" "$KMOD_DIR"
+
+	echo "obj-m :=3D $NAME.o" > "$makefile"
+	echo -n "$NAME-y :=3D init.o" >> "$makefile"
+
+	find "$DIFF_DIR" -type f -name "*.o" | mapfile -t files
+	[[ ${#files[@]} -eq 0 ]] && die "no changes detected"
+
+	for file in "${files[@]}"; do
+		local rel_file=3D"${file#"$DIFF_DIR"/}"
+		local orig_file=3D"$ORIG_DIR/$rel_file"
+		local orig_dir=3D"$(dirname "$orig_file")"
+		local kmod_file=3D"$KMOD_DIR/$rel_file"
+		local kmod_dir=3D"$(dirname "$kmod_file")"
+		local cmd_file=3D"$orig_dir/.$(basename "$file").cmd"
+
+		mkdir -p "$kmod_dir"
+		cp -f "$file" "$kmod_dir"
+		[[ -e "$cmd_file" ]] && cp -f "$cmd_file" "$kmod_dir"
+
+		# Tell kbuild this is a prebuilt object
+		cp -f "$file" "${kmod_file}_shipped"
+
+		echo -n " $rel_file" >> "$makefile"
+	done
+
+	echo >> "$makefile"
+
+	cflags=3D("-ffunction-sections")
+	cflags+=3D("-fdata-sections")
+	[[ $REPLACE -eq 0 ]] && cflags+=3D("-DKLP_NO_REPLACE")
+
+	cmd=3D("make")
+	cmd+=3D("$VERBOSE")
+	cmd+=3D("-j$JOBS")
+	cmd+=3D("--directory=3D.")
+	cmd+=3D("M=3D$KMOD_DIR")
+	cmd+=3D("KCFLAGS=3D${cflags[*]}")
+
+	# Build a "normal" kernel module with init.c and the diffed objects
+	(
+		cd "$SRC"
+		"${cmd[@]}"							\
+			1> >(tee -a "$log")					\
+			2> >(tee -a "$log" >&2)
+	)
+
+	kmod_file=3D"$KMOD_DIR/$NAME.ko"
+
+	# Save off the intermediate binary for debugging
+	cp -f "$kmod_file" "$kmod_file.orig"
+
+	# Work around issue where slight .config change makes corrupt BTF
+	objcopy --remove-section=3D.BTF "$kmod_file"
+
+	# Fix (and work around) linker wreckage for klp syms / relocs
+	"$SRC/tools/objtool/objtool" klp post-link "$kmod_file" || die "objtool klp=
 post-link failed"
+
+	cp -f "$kmod_file" "$OUTFILE"
+}
+
+
+############################################################################=
####
+
+process_args "$@"
+do_init
+
+if (( SHORT_CIRCUIT <=3D 1 )); then
+	status "Validating patch(es)"
+	validate_patches
+	status "Building original kernel"
+	clean_kernel
+	build_kernel
+	status "Copying original object files"
+	copy_orig_objects
+fi
+
+if (( SHORT_CIRCUIT <=3D 2 )); then
+	status "Fixing patch(es)"
+	fix_patches
+	apply_patches
+	status "Building patched kernel"
+	build_kernel
+	revert_patches
+	status "Copying patched object files"
+	copy_patched_objects
+fi
+
+if (( SHORT_CIRCUIT <=3D 3 )); then
+	status "Diffing objects"
+	diff_objects
+fi
+
+if (( SHORT_CIRCUIT <=3D 4 )); then
+	status "Building patch module: $OUTFILE"
+	build_patch_module
+fi
+
+status "SUCCESS"
diff --git a/tools/objtool/klp-diff.c b/tools/objtool/klp-diff.c
index 817d443..4d1f9e9 100644
--- a/tools/objtool/klp-diff.c
+++ b/tools/objtool/klp-diff.c
@@ -241,10 +241,12 @@ static struct symbol *next_file_symbol(struct elf *elf,=
 struct symbol *sym)
 static bool is_uncorrelated_static_local(struct symbol *sym)
 {
 	static const char * const vars[] =3D {
-		"__key.",
-		"__warned.",
 		"__already_done.",
 		"__func__.",
+		"__key.",
+		"__warned.",
+		"_entry.",
+		"_entry_ptr.",
 		"_rs.",
 		"descriptor.",
 		"CSWTCH.",

