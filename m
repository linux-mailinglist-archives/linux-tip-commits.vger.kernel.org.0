Return-Path: <linux-tip-commits+bounces-1623-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0C092A187
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Jul 2024 13:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA0F1C2142C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Jul 2024 11:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598AF7F7D3;
	Mon,  8 Jul 2024 11:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qrsgz0Co";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Do8IP27p"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAD07E782;
	Mon,  8 Jul 2024 11:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720439369; cv=none; b=utWgaZs81qY3/ftBbESo8fbvLSMN3MUsUmKxGvkt2sp5TPMSbray4LenAqsac+6HcxVsDBk4n1vHq+pkRQ2GYncYaAmTfG8CFHE6xlM0Wqo7NYv3xJMBs4WdbmjCfsdS02yWUod+X9qHbv5DNXaBiWub+054YTDLZ/OVkwr7+5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720439369; c=relaxed/simple;
	bh=JMvOIIIwUdwSATWtfKd0c3sMLRV5aQc0P8CA+pcbykU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kD9Q1HtM15q5O/ikQfVASXu2up+3q27QsvkCGpt9Y/zPCnRL328R6UU/ui0YNqRjP+8kRixuDE8Trzq1W4qq7if/ZDp6e13Fj54n7fgZlcOvHM6Tift+iSwTdRRFxdMQyLcBb3jNfCyIGJ0TdVI6sCfxfADROr5SD6heL0VqU9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qrsgz0Co; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Do8IP27p; arc=none smtp.client-ip=193.142.43.55
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
	bh=lXJqXBWEiKwrervet3ens56ojcvaQ3s6gGE6YSi4TJQ=;
	b=qrsgz0CoDBWxiJNbPQMfQuAtBz3dsPRWNG96DBGDEHfrB/USoGOrcQtPEltsPcKDkcMu2/
	Dd4/3l7spWYZC6BHPfkbQtv7LTwu4xygHkUUfzy8ePAM0ArmbYPgBbRRMweaTDqCLK0Ep2
	PmAezkxdB+ekGufA/XSNKKctNuqfP6x4zpGKfgxVS+dsw+sPc/AFeU3h03aloIsRR8Pe6d
	ri9F0Ln1hmbF5nrf6FjYSAGW8v13pgdMcUvCeZHjkiSfeZ8ONPl/r3ACFqhJ5CRQduCq6A
	/2eGoA2AFdMKTXjswB4v7jDphBAyBoMm6xRu6wDIc/n/lY6nXIycp2ujxzxcQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720439365;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lXJqXBWEiKwrervet3ens56ojcvaQ3s6gGE6YSi4TJQ=;
	b=Do8IP27p1iNNsdmFdfDo+0mKBwV8PNPZA+vjtRSsOH5ggRXALc6YG/DZ2r47SDxH2edTXP
	85CC9Hw/ikU5nYAg==
From: "tip-bot2 for Brian Johannesmeyer" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] scripts/faddr2line: Remove call to addr2line from
 find_dir_prefix()
Cc: Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240415145538.1938745-7-bjohannesmeyer@gmail.com>
References: <20240415145538.1938745-7-bjohannesmeyer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172043936523.2215.14997470133117283568.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     406b5c12aad8110e1b1f9355f176cac43cd1fecb
Gitweb:        https://git.kernel.org/tip/406b5c12aad8110e1b1f9355f176cac43cd1fecb
Author:        Brian Johannesmeyer <bjohannesmeyer@gmail.com>
AuthorDate:    Mon, 15 Apr 2024 16:55:37 +02:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 02 Jul 2024 23:38:37 -07:00

scripts/faddr2line: Remove call to addr2line from find_dir_prefix()

Use the single long-running faddr2line process from find_dir_prefix().

Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Link: https://lore.kernel.org/r/20240415145538.1938745-7-bjohannesmeyer@gmail.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/faddr2line | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 48fc8cf..1fa6bee 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -85,15 +85,17 @@ command -v ${ADDR2LINE} >/dev/null 2>&1 || die "${ADDR2LINE} isn't installed"
 # init/main.c!  This only works for vmlinux.  Otherwise it falls back to
 # printing the absolute path.
 find_dir_prefix() {
-	local objfile=$1
-
 	local start_kernel_addr=$(echo "${ELF_SYMS}" | sed 's/\[.*\]//' |
 		${AWK} '$8 == "start_kernel" {printf "0x%s", $2}')
 	[[ -z $start_kernel_addr ]] && return
 
-	local file_line=$(${ADDR2LINE} -e $objfile $start_kernel_addr)
-	[[ -z $file_line ]] && return
+	run_addr2line ${start_kernel_addr} ""
+	[[ -z $ADDR2LINE_OUT ]] && return
 
+	local file_line=${ADDR2LINE_OUT#* at }
+	if [[ -z $file_line ]] || [[ $file_line = $ADDR2LINE_OUT ]]; then
+		return
+	fi
 	local prefix=${file_line%init/main.c:*}
 	if [[ -z $prefix ]] || [[ $prefix = $file_line ]]; then
 		return
@@ -350,7 +352,7 @@ echo "${ELF_SECHEADERS}" | ${GREP} -q '\.debug_info' || die "CONFIG_DEBUG_INFO n
 init_addr2line $objfile
 
 DIR_PREFIX=supercalifragilisticexpialidocious
-find_dir_prefix $objfile
+find_dir_prefix
 
 FIRST=1
 while [[ $# -gt 0 ]]; do

