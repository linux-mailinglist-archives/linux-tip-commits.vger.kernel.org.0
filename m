Return-Path: <linux-tip-commits+bounces-1627-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6082B92A194
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Jul 2024 13:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0FDFB23854
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Jul 2024 11:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A901823CD;
	Mon,  8 Jul 2024 11:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DSVoFsne";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XoNLM1En"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CED780631;
	Mon,  8 Jul 2024 11:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720439372; cv=none; b=MPjzHHPcPgn05bUWNite2EUC5yJzTP1F08/obn4O0B5yInC9Gtk/N1H5im3J0FvY7NJizLJDlJQvebcjRcG9mCKxxuUOIzFCfDkcMHChEEQSr8PMs4jECq/6ZwyK774eacBfvTDiO4jVszy8ZkRGbaAEGhJWLM4MJu+N3uyHnBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720439372; c=relaxed/simple;
	bh=wokYTWcyBkpC5n1L6XsoYEfkYApHYqab+bnsIyqu++s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KcgNTx87lGhIO5KBn1KjORI/aGqwAQO9lzftgiCV9hh/L3dfhj1vDeS9z8qlMI56thH85NIUE3AK0zo2VDx5NMmUzRlU2yH3yojAprqWFW4EaHc0028U4fNaqXl2z8RnDllk1fi93OdP/tyQxEvmqBMXk7sUVVhcIX87nv51ykI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DSVoFsne; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XoNLM1En; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Jul 2024 11:49:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720439366;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YTsF7AA+kqMcXTyp0AQsHoZMizTKW5ptwHVi/MyMvOs=;
	b=DSVoFsneGrYSruX/OlFBVAECeD6i87//6upiuj6X7egDayLPgQ4xPEmw1h2k1/RU7l/IjB
	e6FkR4YZv6udZcn+DKzuzRpvYvpLcDi613s0h/74/jrJ+38Ji6kTVzzWGntYPlp8i7Xdi3
	ollHNWUqDTleoSGBt7jmV/6PxGP2NW5HRVNRVsHu1A2Aw4b7Psc7ORC27rlYFfUVJPyrXT
	hJaPGyZVGd/sSW2LeksplxIhJGVaKlKQBNGMCF92igJv8gzh1tsmcEA4zm14Y6jWJLwwf6
	9D1Of2wZIyWAVtxMYWe0gXNFGynGJYMmBFxHGjoixRYYjRxcU2YER4s1PWH+vA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720439366;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YTsF7AA+kqMcXTyp0AQsHoZMizTKW5ptwHVi/MyMvOs=;
	b=XoNLM1EnctqyZbyf3iYQ4/6TONATGKN0wCHq5VaFdaSr40QT3emeTH0TGTBrcMiyXy1h/7
	dPZfgkwbk9EvmeCw==
From: "tip-bot2 for Brian Johannesmeyer" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] scripts/faddr2line: Check vmlinux only once
Cc: Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240415145538.1938745-4-bjohannesmeyer@gmail.com>
References: <20240415145538.1938745-4-bjohannesmeyer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172043936588.2215.1170658880953714160.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     2c809186ccf0e3a4cb952da181f9c28436133081
Gitweb:        https://git.kernel.org/tip/2c809186ccf0e3a4cb952da181f9c28436133081
Author:        Brian Johannesmeyer <bjohannesmeyer@gmail.com>
AuthorDate:    Mon, 15 Apr 2024 16:55:34 +02:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 02 Jul 2024 23:38:36 -07:00

scripts/faddr2line: Check vmlinux only once

Rather than checking whether the object file is vmlinux for each invocation
of __faddr2line, check it only once beforehand.

Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Link: https://lore.kernel.org/r/20240415145538.1938745-4-bjohannesmeyer@gmail.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/faddr2line | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index f011bda..bb3b5f0 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -115,6 +115,17 @@ run_readelf() {
 	ELF_SYMS=$(echo "${out}" | sed -n '/Symbol table .* contains [0-9]* entries:/,$p')
 }
 
+check_vmlinux() {
+	# vmlinux uses absolute addresses in the section table rather than
+	# section offsets.
+	IS_VMLINUX=0
+	local file_type=$(echo "${ELF_FILEHEADER}" |
+		${AWK} '$1 == "Type:" { print $2; exit }')
+	if [[ $file_type = "EXEC" ]] || [[ $file_type == "DYN" ]]; then
+		IS_VMLINUX=1
+	fi
+}
+
 __faddr2line() {
 	local objfile=$1
 	local func_addr=$2
@@ -125,8 +136,6 @@ __faddr2line() {
 	local func_offset=${func_addr#*+}
 	func_offset=${func_offset%/*}
 	local user_size=
-	local file_type
-	local is_vmlinux=0
 	[[ $func_addr =~ "/" ]] && user_size=${func_addr#*/}
 
 	if [[ -z $sym_name ]] || [[ -z $func_offset ]] || [[ $sym_name = $func_addr ]]; then
@@ -135,14 +144,6 @@ __faddr2line() {
 		return
 	fi
 
-	# vmlinux uses absolute addresses in the section table rather than
-	# section offsets.
-	local file_type=$(echo "${ELF_FILEHEADER}" |
-		${AWK} '$1 == "Type:" { print $2; exit }')
-	if [[ $file_type = "EXEC" ]] || [[ $file_type == "DYN" ]]; then
-		is_vmlinux=1
-	fi
-
 	# Go through each of the object's symbols which match the func name.
 	# In rare cases there might be duplicates, in which case we print all
 	# matches.
@@ -260,7 +261,7 @@ __faddr2line() {
 		# Pass section address to addr2line and strip absolute paths
 		# from the output:
 		local args="--functions --pretty-print --inlines --exe=$objfile"
-		[[ $is_vmlinux = 0 ]] && args="$args --section=$sec_name"
+		[[ $IS_VMLINUX = 0 ]] && args="$args --section=$sec_name"
 		local output=$(${ADDR2LINE} $args $addr | sed "s; $dir_prefix\(\./\)*; ;")
 		[[ -z $output ]] && continue
 
@@ -305,6 +306,8 @@ run_readelf $objfile
 
 echo "${ELF_SECHEADERS}" | ${GREP} -q '\.debug_info' || die "CONFIG_DEBUG_INFO not enabled"
 
+check_vmlinux
+
 DIR_PREFIX=supercalifragilisticexpialidocious
 find_dir_prefix $objfile
 

