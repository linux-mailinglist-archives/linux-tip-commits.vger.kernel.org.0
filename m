Return-Path: <linux-tip-commits+bounces-1628-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E75E92A195
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Jul 2024 13:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A701F222AA
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Jul 2024 11:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647598249B;
	Mon,  8 Jul 2024 11:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fWn/hygu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jCzD+Sm8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF4C80635;
	Mon,  8 Jul 2024 11:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720439372; cv=none; b=JA1AOq0VmKNuM59MTNph1aT/Sr+sOY6iSrNX4MuvIgA+5Zl+IkKdp1olvNV6L8/DBisLieK1Xec7FVGhwX8EeAahtn6fKwMs/G2hVVHRQeka6FSyh1ZFXoVH1Kea8xfuafSRSESGoqp3W/K6Jz6NwSiYxvE5HGIQ+N6uz5UlSDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720439372; c=relaxed/simple;
	bh=jBlkyAPNtd0Ap7FtDbpc2YGw+ApdIthKTQelheuVDz4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DP2PUAocnpAaO7YJ3s0KOXD1mYNKEi5bxnQY8K4oJTKYD7hzazJJWInifl4gVf8NCWT3TbdywH51jB0s13Mu3vMuHVvU5mFYjHq3mmqbEHUTV6pwfu6I7YeNDzPNbY5i0Olx5CYaOeEFsu3jgzMdS50MzbhIRN3WVlfxm5YQrPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fWn/hygu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jCzD+Sm8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Jul 2024 11:49:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720439366;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PbsZ3rfk8ZW6MPYXF75BfnIMxeAowy+66UhB+KjF1u0=;
	b=fWn/hygu3ohl7VcJ4lhtBtNfM+ISK2omEfSn1jrkt2ttGlXcEZiHhhiCcWy5S5iacuFCf3
	dI2hioWRValVXZLRzqzRXJmgJthguXclTcaD4VYt5E4qGp0UlCIvuyQ6IT40SAcf02mKoZ
	cmj1Q6cE3VeVDFm6WkvQbKJ43+94uGDTYv0js9js7E1gg+D+KI27lEaywFZolK/qpmc/gw
	bSCEGhTrvJKMGviIKsJy/XKb6DLteC7JWxY+wPmrktC7io+0KZplR+BzQomfF9hbWgYl/P
	3fKfivPX2y+PULN3v+Rx+RbzTewyn/VPuriUFjgyxJrjW+4p5P7jIFGSKUaaSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720439366;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PbsZ3rfk8ZW6MPYXF75BfnIMxeAowy+66UhB+KjF1u0=;
	b=jCzD+Sm8TqenIuckhcf4yvRyABs6ge6+HuLbfTTdQPC5yccV+iK60cVNEXqk9aPcX2uGVf
	yTJIiuUlNUIc/5Cw==
From: "tip-bot2 for Brian Johannesmeyer" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] scripts/faddr2line: Reduce number of readelf
 calls to three
Cc: Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240415145538.1938745-2-bjohannesmeyer@gmail.com>
References: <20240415145538.1938745-2-bjohannesmeyer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172043936631.2215.8839438073789084491.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     39cf650d68289d41d484f4c29fea0124df2e09aa
Gitweb:        https://git.kernel.org/tip/39cf650d68289d41d484f4c29fea0124df2e09aa
Author:        Brian Johannesmeyer <bjohannesmeyer@gmail.com>
AuthorDate:    Mon, 15 Apr 2024 16:55:32 +02:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 02 Jul 2024 23:38:36 -07:00

scripts/faddr2line: Reduce number of readelf calls to three

Rather than calling readelf several times for each invocation of
__faddr2line, call readelf only three times at the beginning, and save its
result for future use.

Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Link: https://lore.kernel.org/r/20240415145538.1938745-2-bjohannesmeyer@gmail.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/faddr2line | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 587415a..bf394bf 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -87,7 +87,7 @@ command -v ${ADDR2LINE} >/dev/null 2>&1 || die "${ADDR2LINE} isn't installed"
 find_dir_prefix() {
 	local objfile=$1
 
-	local start_kernel_addr=$(${READELF} --symbols --wide $objfile | sed 's/\[.*\]//' |
+	local start_kernel_addr=$(echo "${ELF_SYMS}" | sed 's/\[.*\]//' |
 		${AWK} '$8 == "start_kernel" {printf "0x%s", $2}')
 	[[ -z $start_kernel_addr ]] && return
 
@@ -103,6 +103,14 @@ find_dir_prefix() {
 	return 0
 }
 
+run_readelf() {
+	local objfile=$1
+
+	ELF_FILEHEADER=$(${READELF} --file-header $objfile)
+	ELF_SECHEADERS=$(${READELF} --section-headers --wide $objfile)
+	ELF_SYMS=$(${READELF} --symbols --wide $objfile)
+}
+
 __faddr2line() {
 	local objfile=$1
 	local func_addr=$2
@@ -125,7 +133,7 @@ __faddr2line() {
 
 	# vmlinux uses absolute addresses in the section table rather than
 	# section offsets.
-	local file_type=$(${READELF} --file-header $objfile |
+	local file_type=$(echo "${ELF_FILEHEADER}" |
 		${AWK} '$1 == "Type:" { print $2; exit }')
 	if [[ $file_type = "EXEC" ]] || [[ $file_type == "DYN" ]]; then
 		is_vmlinux=1
@@ -143,8 +151,7 @@ __faddr2line() {
 		local sec_name
 
 		# Get the section size:
-		sec_size=$(${READELF} --section-headers --wide $objfile |
-			sed 's/\[ /\[/' |
+		sec_size=$(echo "${ELF_SECHEADERS}" | sed 's/\[ /\[/' |
 			${AWK} -v sec=$sym_sec '$1 == "[" sec "]" { print "0x" $6; exit }')
 
 		if [[ -z $sec_size ]]; then
@@ -154,8 +161,7 @@ __faddr2line() {
 		fi
 
 		# Get the section name:
-		sec_name=$(${READELF} --section-headers --wide $objfile |
-			sed 's/\[ /\[/' |
+		sec_name=$(echo "${ELF_SECHEADERS}" | sed 's/\[ /\[/' |
 			${AWK} -v sec=$sym_sec '$1 == "[" sec "]" { print $2; exit }')
 
 		if [[ -z $sec_name ]]; then
@@ -197,7 +203,7 @@ __faddr2line() {
 				found=2
 				break
 			fi
-		done < <(${READELF} --symbols --wide $objfile | sed 's/\[.*\]//' | ${AWK} -v sec=$sym_sec '$7 == sec' | sort --key=2)
+		done < <(echo "${ELF_SYMS}" | sed 's/\[.*\]//' | ${AWK} -v sec=$sym_sec '$7 == sec' | sort --key=2)
 
 		if [[ $found = 0 ]]; then
 			warn "can't find symbol: sym_name: $sym_name sym_sec: $sym_sec sym_addr: $sym_addr sym_elf_size: $sym_elf_size"
@@ -278,7 +284,7 @@ __faddr2line() {
 
 		DONE=1
 
-	done < <(${READELF} --symbols --wide $objfile | sed 's/\[.*\]//' | ${AWK} -v fn=$sym_name '$8 == fn')
+	done < <(echo "${ELF_SYMS}" | sed 's/\[.*\]//' | ${AWK} -v fn=$sym_name '$8 == fn')
 }
 
 [[ $# -lt 2 ]] && usage
@@ -291,7 +297,9 @@ LIST=0
 [[ ! -f $objfile ]] && die "can't find objfile $objfile"
 shift
 
-${READELF} --section-headers --wide $objfile | ${GREP} -q '\.debug_info' || die "CONFIG_DEBUG_INFO not enabled"
+run_readelf $objfile
+
+echo "${ELF_SECHEADERS}" | ${GREP} -q '\.debug_info' || die "CONFIG_DEBUG_INFO not enabled"
 
 DIR_PREFIX=supercalifragilisticexpialidocious
 find_dir_prefix $objfile

