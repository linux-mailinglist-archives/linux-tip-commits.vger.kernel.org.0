Return-Path: <linux-tip-commits+bounces-1629-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E32892A19A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Jul 2024 13:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1443B238D4
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Jul 2024 11:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A921839EB;
	Mon,  8 Jul 2024 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m7jomRyE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ccv/S2n9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F35280638;
	Mon,  8 Jul 2024 11:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720439373; cv=none; b=uiMwFhfbb6C71En8k/T6Fx5pKaulUWHcPpS/vO5x/l5SzcB4j+J/jTrNJ6lJYiX27H+bByvoyqBqWeeHT1lLzk9wnGg98oPlYb4aq575rGBi4pqD42iYQApkDEWhCXXzHW52HlTUyQACBTNuo7/lGyqzYXrMsg2LPutSC/JL5iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720439373; c=relaxed/simple;
	bh=vi48NEdXAo1IRu7REGJgNvpCnp3v4LLZNW/5lxQiZDQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fsZroTzXAGYVNInJClg7jkiuyVjjosUTGk5jDkazvcaKIDVgR/hJrM+DAcm2SkZNhPbzGzGJf2Jq0Lq1WrhavJ397H0KiNP6Hu/SUCmZPS3ui/BpzrLME9mBbQtzhMQ7359pjNVK6RJTXFfN3isiD1IPxg2wXMBcOoMKhQBEIuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m7jomRyE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ccv/S2n9; arc=none smtp.client-ip=193.142.43.55
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
	bh=NVdfKlL8poxlXvdZU0kwr06DAwc71YbDa7a7oPNvn7I=;
	b=m7jomRyEEWFT1Dr6tzVgN88mu8S1dyASM89cJbmSpgcoX/AljSzX6emlHG4eL5pgz5f47O
	fWKACeTItht8f7le7VqkllLgw9Yu31j5WRTQ88y4fZ2/fyKKWWwVLc/Lk8pQZyOSVWVQZ+
	ALcmLSmOyDcQ66X1njyNiajudHfjFPUV5kZFVVM/J6p3yOU46vqhLc7BvuWCpZfpL8SdbN
	L4BQCMrrj1+B+y/BlMgvb4s2pJwxeoAsZqDtaEvflDyR/U/OP0IIohuFkVns+uEzp/xdmz
	MK12FYIg4Wwn9a+EmwAawadQV4HAUlDlmePJo9VGtPdZFQhgciG/gS+4+/vPjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720439366;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NVdfKlL8poxlXvdZU0kwr06DAwc71YbDa7a7oPNvn7I=;
	b=ccv/S2n9XYFSfg9NzF+xMrBFx6969bRuj1uW6smJ5C3DFOtQe3EILMdAW28Q1BtGGV12pu
	znsvAVFUSiRtPoCw==
From: "tip-bot2 for Brian Johannesmeyer" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] scripts/faddr2line: Combine three readelf calls into one
Cc: Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240415145538.1938745-3-bjohannesmeyer@gmail.com>
References: <20240415145538.1938745-3-bjohannesmeyer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172043936609.2215.5281286773212396391.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     b8d9d9496c1e78a8fd89f4fe9923d12b3c9ad8a3
Gitweb:        https://git.kernel.org/tip/b8d9d9496c1e78a8fd89f4fe9923d12b3c9ad8a3
Author:        Brian Johannesmeyer <bjohannesmeyer@gmail.com>
AuthorDate:    Mon, 15 Apr 2024 16:55:33 +02:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 02 Jul 2024 23:38:36 -07:00

scripts/faddr2line: Combine three readelf calls into one

Rather than calling readelf three separate times to collect three different
types of info, call it only once, and parse out the different types of info
from its output.

Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Link: https://lore.kernel.org/r/20240415145538.1938745-3-bjohannesmeyer@gmail.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/faddr2line | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index bf394bf..f011bda 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -105,10 +105,14 @@ find_dir_prefix() {
 
 run_readelf() {
 	local objfile=$1
-
-	ELF_FILEHEADER=$(${READELF} --file-header $objfile)
-	ELF_SECHEADERS=$(${READELF} --section-headers --wide $objfile)
-	ELF_SYMS=$(${READELF} --symbols --wide $objfile)
+	local out=$(${READELF} --file-header --section-headers --symbols --wide $objfile)
+
+	# This assumes that readelf first prints the file header, then the section headers, then the symbols.
+	# Note: It seems that GNU readelf does not prefix section headers with the "There are X section headers"
+	# line when multiple options are given, so let's also match with the "Section Headers:" line.
+	ELF_FILEHEADER=$(echo "${out}" | sed -n '/There are [0-9]* section headers, starting at offset\|Section Headers:/q;p')
+	ELF_SECHEADERS=$(echo "${out}" | sed -n '/There are [0-9]* section headers, starting at offset\|Section Headers:/,$p' | sed -n '/Symbol table .* contains [0-9]* entries:/q;p')
+	ELF_SYMS=$(echo "${out}" | sed -n '/Symbol table .* contains [0-9]* entries:/,$p')
 }
 
 __faddr2line() {

