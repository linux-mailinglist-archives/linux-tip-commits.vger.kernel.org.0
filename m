Return-Path: <linux-tip-commits+bounces-1624-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0158692A188
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Jul 2024 13:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB48828379F
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Jul 2024 11:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE5B7FBC1;
	Mon,  8 Jul 2024 11:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MUyY6MBT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j/8rNp0/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEBC7C081;
	Mon,  8 Jul 2024 11:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720439369; cv=none; b=ACNUhdKLoFyJghw7x2rEsq+g2VTVqDfPr0BWv2QcacAR5sd1qW4bOkklG3BvMLbFuWdr4f0/+giwZSzgvDaEqUdcoZsRvCtXCTXulm8gEJjGKgp0L9gHYdYWU84Su4YZh/VRv1xrrLkWVfqDLT/K0BRGe/bLeFxDxzyQ+DA9ttE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720439369; c=relaxed/simple;
	bh=FtaFVALYwIkUsySau/heuV6WhTmm4OoeH3g3/VEnOdY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hzMh539OOBPcSz++R8h4MQCuVKEayfDrpGNRX+4Co7Bk/56vOq/PdQ3XW+0oFV9Q5J3cxltq8sSL4Ks4MsFZS4pNuYTg11XOE6BUegGWBcvYC9lhIsmeghOF+8gvgB0VSC3Kzb5Z+URrAA/fYuWhlXUWwZD75FZEsgv9s6VWxuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MUyY6MBT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j/8rNp0/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Jul 2024 11:49:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720439365;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uf2CQnkVDyheqTK58lLBnpwbPOAH4iRIW4ujULuE+WA=;
	b=MUyY6MBT1+3qKsOPcmlBNyJeU8g3/rB2kg507O8PMQfH1jkE/2ulwtfSNxO37zI7yn+VXt
	BRSt+i+QtqirEXPZ3RVGI4/qJZlRk/Q7Q3j89PJw/37QLnc8w2NcQXv7WZWWxRVtTPOyAW
	IjffXjIepe8Qsjd/AeqKZpiUPfn3KW4VJMkcFH+mzE2zunS6buzKi2J0c2HsR3YW+L9CW/
	kcpFJ82XIMmat4Ii/GsOlQ20Vfre4/jahRO1UAw9BYyVHEDCMxGQl4mro+c8q0J0QDLUcW
	kC6AjhIQAhXyuDg0rjHYEFupRAdlA1d67G550HxyXJVNcicP22cE97RukoVdxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720439365;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uf2CQnkVDyheqTK58lLBnpwbPOAH4iRIW4ujULuE+WA=;
	b=j/8rNp0/JAjpnMUx9f7EvPHfRMRqeNW63keVH5cis3p5aExF2tU87R59glA9HmvG0UxYgz
	KfuIAmr008A6KiCg==
From: "tip-bot2 for Brian Johannesmeyer" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] scripts/faddr2line: Invoke addr2line as a single
 long-running process
Cc: Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240415145538.1938745-6-bjohannesmeyer@gmail.com>
References: <20240415145538.1938745-6-bjohannesmeyer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172043936543.2215.9070138494709130266.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     e36b69e918112430ee53e24238bb87f5146f9acf
Gitweb:        https://git.kernel.org/tip/e36b69e918112430ee53e24238bb87f5146f9acf
Author:        Brian Johannesmeyer <bjohannesmeyer@gmail.com>
AuthorDate:    Mon, 15 Apr 2024 16:55:36 +02:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 02 Jul 2024 23:38:36 -07:00

scripts/faddr2line: Invoke addr2line as a single long-running process

Rather than invoking a separate addr2line process for each address, invoke
a single addr2line coprocess, and pass each address to its stdin. Previous
work [0] applied a similar change to perf, leading to a ~60x speed-up [1].

If using an object file that is _not_ vmlinux, faddr2line passes a section
name argument to addr2line. Because we do not know until runtime which
section names will be passed to addr2line, we cannot apply this change to
non-vmlinux object files. Hence, it only applies to vmlinux.

[0] commit be8ecc57f180 ("perf srcline: Use long-running addr2line per
DSO")
[1] Link:
https://eighty-twenty.org/2021/09/09/perf-addr2line-speed-improvement

Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Link: https://lore.kernel.org/r/20240415145538.1938745-6-bjohannesmeyer@gmail.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/faddr2line | 52 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 820680c..48fc8cf 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -126,6 +126,48 @@ check_vmlinux() {
 	fi
 }
 
+init_addr2line() {
+	local objfile=$1
+
+	check_vmlinux
+
+	ADDR2LINE_ARGS="--functions --pretty-print --inlines --addresses --exe=$objfile"
+	if [[ $IS_VMLINUX = 1 ]]; then
+		# If the executable file is vmlinux, we don't pass section names to
+		# addr2line, so we can launch it now as a single long-running process.
+		coproc ADDR2LINE_PROC (${ADDR2LINE} ${ADDR2LINE_ARGS})
+	fi
+}
+
+run_addr2line() {
+	local addr=$1
+	local sec_name=$2
+
+	if [[ $IS_VMLINUX = 1 ]]; then
+		# We send to the addr2line process: (1) the address, then (2) a sentinel
+		# value, i.e., something that can't be interpreted as a valid address
+		# (i.e., ","). This causes addr2line to write out: (1) the answer for
+		# our address, then (2) either "?? ??:0" or "0x0...0: ..." (if
+		# using binutils' addr2line), or "," (if using LLVM's addr2line).
+		echo ${addr} >& "${ADDR2LINE_PROC[1]}"
+		echo "," >& "${ADDR2LINE_PROC[1]}"
+		local first_line
+		read -r first_line <& "${ADDR2LINE_PROC[0]}"
+		ADDR2LINE_OUT=$(echo "${first_line}" | sed 's/^0x[0-9a-fA-F]*: //')
+		while read -r line <& "${ADDR2LINE_PROC[0]}"; do
+			if [[ "$line" == "?? ??:0" ]] || [[ "$line" == "," ]] || [[ $(echo "$line" | ${GREP} "^0x00*: ") ]]; then
+				break
+			fi
+			ADDR2LINE_OUT+=$'\n'$(echo "$line" | sed 's/^0x[0-9a-fA-F]*: //')
+		done
+	else
+		# Run addr2line as a single invocation.
+		local sec_arg
+		[[ -z $sec_name ]] && sec_arg="" || sec_arg="--section=${sec_name}"
+		ADDR2LINE_OUT=$(${ADDR2LINE} ${ADDR2LINE_ARGS} ${sec_arg} ${addr} | sed 's/^0x[0-9a-fA-F]*: //')
+	fi
+}
+
 __faddr2line() {
 	local objfile=$1
 	local func_addr=$2
@@ -260,12 +302,8 @@ __faddr2line() {
 
 		# Pass section address to addr2line and strip absolute paths
 		# from the output:
-		local args="--functions --pretty-print --inlines --addresses --exe=$objfile"
-		[[ $IS_VMLINUX = 0 ]] && args="$args --section=$sec_name"
-		local output_with_addr=$(${ADDR2LINE} $args $addr | sed "s; $dir_prefix\(\./\)*; ;")
-		[[ -z $output_with_addr ]] && continue
-
-		local output=$(echo "${output_with_addr}" | sed 's/^0x[0-9a-fA-F]*: //')
+		run_addr2line $addr $sec_name
+		local output=$(echo "${ADDR2LINE_OUT}" | sed "s; $dir_prefix\(\./\)*; ;")
 		[[ -z $output ]] && continue
 
 		# Default output (non --list):
@@ -309,7 +347,7 @@ run_readelf $objfile
 
 echo "${ELF_SECHEADERS}" | ${GREP} -q '\.debug_info' || die "CONFIG_DEBUG_INFO not enabled"
 
-check_vmlinux
+init_addr2line $objfile
 
 DIR_PREFIX=supercalifragilisticexpialidocious
 find_dir_prefix $objfile

