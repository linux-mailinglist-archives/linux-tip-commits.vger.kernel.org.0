Return-Path: <linux-tip-commits+bounces-7785-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BCDCF4881
	for <lists+linux-tip-commits@lfdr.de>; Mon, 05 Jan 2026 16:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50B593023D01
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jan 2026 15:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EC0301717;
	Mon,  5 Jan 2026 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Iqe7WmyO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ua0m7X0g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9137E314A6F;
	Mon,  5 Jan 2026 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628436; cv=none; b=YOUwCcPVe9BqmcyofqufOFabX35izR8kiIlLIEdb0tJ9+8Wm+jEm620R81OzFn/Q6kLFJjbXjScvuLFfWoZqF1Y36FBfpEcHGa8JlnWtlFLe39giPSKY2LNF/vacpNE3bNn1xC8HvtTeGZv+DtLEtqS6c2iRyghVS2PA3AX25DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628436; c=relaxed/simple;
	bh=0QYFst3l84d10zs3Eh6nA2U4Q+oYSe6jm56JssLHC6k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dWwz8G2YZ+ho4UbRCn5lHItRXH1at2ZMWS34szWss1c5pBH0EY/1+zogaLl0saHjJlCJ3aS9w3BfyMiwiInQugNzFE3nJby432iwY74pArwB8/7izNvR6ASaTNBYO4nZUeq3oF+OWQV+Lox77XRHWj3Hy1dk4pFsFi5YxkBNSlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Iqe7WmyO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ua0m7X0g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Jan 2026 15:53:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767628432;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VpKotoQM5mi2uf1XMyKJSEIZA9o9VsMTrDUqxwckA6w=;
	b=Iqe7WmyORzCw0+o2NBWPXC3VF73ohgL4S42MZ5WP/g68J8C68GS784+Hb5xG43m0l88KgI
	lQvK/U1LYwEodxHpjrYekkjQlI+9u5DTco2nG3yKH3yQFWCpcWyMWd0pYjrv8E560AiSvB
	XzPrHlSOSB51wVoHI8g32Wu4gsMYq7LxCPkylaGgTLSFnoLf2S1YM/DZbNRVzRlns52OSt
	xhABZhU35htUcn/CS5eTkeT293dIs1d/4orY+SNfxg8Us+W8emvJ63k3Zpf+hrqp8g6sEx
	Lr4MQH2/DZQZ3NSBJi3Akz3XHfUiy7zzqLN/FBZNUs6cNNb864zcZ4Fdbq0c6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767628432;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VpKotoQM5mi2uf1XMyKJSEIZA9o9VsMTrDUqxwckA6w=;
	b=Ua0m7X0gB7yFetxvYKlbQhmPvAYadpxU7wlI2W5GirPcMYhrmdb0ia9JuyM6FzaiJmRXid
	iKI7RT8WCBgk7SDA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] tags: Add regex for context_lock_struct
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251220133307.GR3707891@noisy.programming.kicks-ass.net>
References: <20251220133307.GR3707891@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176762843115.510.5971560160976835265.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c10d860e0baae0853773dc90a94b26adc5687380
Gitweb:        https://git.kernel.org/tip/c10d860e0baae0853773dc90a94b26adc56=
87380
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 05 Jan 2026 16:24:05 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jan 2026 16:43:37 +01:00

tags: Add regex for context_lock_struct

With the introduction of compiler context analysis (LLVM
ThreadSafetyAnalysis) the struct definition of various locks get
wrapped in a macro. This hides them from tags based navigation,
although clangd/LSP sees right through it and works as expected.

Add a regex to the tags script to help it along.

Requested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251220133307.GR3707891@noisy.programming.kic=
ks-ass.net
---
 scripts/tags.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index 99ce427..2433736 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -221,6 +221,7 @@ regex_c=3D(
 	'/^\<DEFINE_GUARD_COND(\([[:alnum:]_]\+\),[[:space:]]*\([[:alnum:]_]\+\)/cl=
ass_\1\2/'
 	'/^\<DEFINE_LOCK_GUARD_[[:digit:]](\([[:alnum:]_]\+\)/class_\1/'
 	'/^\<DEFINE_LOCK_GUARD_[[:digit:]]_COND(\([[:alnum:]_]\+\),[[:space:]]*\([[=
:alnum:]_]\+\)/class_\1\2/'
+	'/^context_lock_struct(\([^,)]*\)[^)]*)/struct \1/'
 )
 regex_kconfig=3D(
 	'/^[[:blank:]]*\(menu\|\)config[[:blank:]]\+\([[:alnum:]_]\+\)/\2/'

