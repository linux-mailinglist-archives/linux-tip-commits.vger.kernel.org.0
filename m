Return-Path: <linux-tip-commits+bounces-4725-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA33A7DE7F
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 15:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8A0E16A6FB
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 13:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1D824BCF9;
	Mon,  7 Apr 2025 13:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QeQkPxBC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gD2vDOTh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFBB22B8AB;
	Mon,  7 Apr 2025 13:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031198; cv=none; b=IJH7sCaA57hyx2tFLg6eGzMorZmJWh27b2QdGZuLesrBP8DpzTnz0uryIkXM1qw+4GIdXU/X8J5SqumISpT+gBD62rXa2Irc+yLwjHsF1hSRefm4KcJ2UqiXo0gEPG0H2nqLnGrr5sSbG90yvTdv6Gji/8by19esYMYKE73NpNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031198; c=relaxed/simple;
	bh=4il+HotzhlVVEHUZXJvUut3Fviv7uoztwUZyBpLG0wY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QL/5wpWBacvuojToshzqR1KaVe8etghM6nOwRPplGyQitwrrWzxv4KyAuOlD3hgui6jVW/dCSSap7mOWK5oz7dHsQJIy2mD1UWEWhr4hGOKMEgdiK1Nu9qjphkY0O13hqx3wtY5eJkFoC+EL5eF2sAgQhasUC5JqWZXCc1R6pOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QeQkPxBC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gD2vDOTh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Apr 2025 13:06:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744031187;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5EZ/1gJ5T5oT17yvV4r2Fbnb/Lj+dlo7WNR85K2DgTQ=;
	b=QeQkPxBCNKqZyTkYSxcYhzaAZrX48MsHIxRIh0pm1W1MHLwoTBfL9w//+hQ9M1iL2sCnlm
	6c0EpI5tou/CtrPSNqVKe/BPVR+73vf+ODZu4ZFj4RaSPoaD+ynkhu+t3eS2Q3GEQEP/KS
	ybd386GYL+mym49P+UGuk+DTbWGHBWLQCIjHyOnrCZFrGEXqi0PkRvmIxY+ErUPPUbyNzX
	c8h0P3Lh36aAqmKQKIRf+ztSIznSJH4f1ySbcimRjVxr8fhYpil2FfB8l/m7PgamSV0RHw
	JvmHEWErRPS/l/Pa/i7e67GX9TmvhOtXBDUvdP1ve28a0LOnU464UBnFx6RkNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744031187;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5EZ/1gJ5T5oT17yvV4r2Fbnb/Lj+dlo7WNR85K2DgTQ=;
	b=gD2vDOThS/FQ5xzcs9t+LFjmQvPCEmwzKrsLqhNVO8J3XkUpqYmAqKrL0I64PTTTsZHkBn
	HBZXcrm8Oz5RNMDg==
From: "tip-bot2 for Boris Ostrovsky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/AMD: Clean the cache if update did
 not load microcode
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250327230503.1850368-3-boris.ostrovsky@oracle.com>
References: <20250327230503.1850368-3-boris.ostrovsky@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174403118308.31282.8495809232181072693.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     321550859f3bd64f547d0b4e9fbd97bd539ef47c
Gitweb:        https://git.kernel.org/tip/321550859f3bd64f547d0b4e9fbd97bd539ef47c
Author:        Boris Ostrovsky <boris.ostrovsky@oracle.com>
AuthorDate:    Thu, 27 Mar 2025 19:05:03 -04:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 07 Apr 2025 14:46:56 +02:00

x86/microcode/AMD: Clean the cache if update did not load microcode

If microcode did not get loaded there is no reason to keep it in the cache.
Moreover, if loading failed it will not be possible to load an earlier version
of microcode since the failed revision will always be selected from the cache
on the next reload attempt.

Since the failed revisions is not easily available at this point just clean the
whole cache. It will be rebuilt later if needed.

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250327230503.1850368-3-boris.ostrovsky@oracle.com
---
 arch/x86/kernel/cpu/microcode/amd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index b61028c..57bd61f 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -1171,11 +1171,18 @@ static void microcode_fini_cpu_amd(int cpu)
 	uci->mc = NULL;
 }
 
+static void finalize_late_load_amd(int result)
+{
+	if (result)
+		cleanup();
+}
+
 static struct microcode_ops microcode_amd_ops = {
 	.request_microcode_fw	= request_microcode_amd,
 	.collect_cpu_info	= collect_cpu_info_amd,
 	.apply_microcode	= apply_microcode_amd,
 	.microcode_fini_cpu	= microcode_fini_cpu_amd,
+	.finalize_late_load	= finalize_late_load_amd,
 	.nmi_safe		= true,
 };
 

