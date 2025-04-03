Return-Path: <linux-tip-commits+bounces-4643-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58DBA7A3D5
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 15:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFE633B7341
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 13:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D9A2505A6;
	Thu,  3 Apr 2025 13:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vXWPkZEr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tyq2ECWL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D333B24F5A7;
	Thu,  3 Apr 2025 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743687225; cv=none; b=aXq7+vXMXQUcPzOqZ+Orov/c3fYB0HyvLRKswtk7CYXEBGhTISpvZc026IOMcAC2F6ONFpdjv6SUWVgcJxRz4FMeRZVyFqDqgWFpp29XYoiXI6ef0a2uzBU1fYlDSiRf0gfrrnBdPqoi474ZEynZe6yyVRkt5pyBZ+cZGMTbGrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743687225; c=relaxed/simple;
	bh=KyV4jTxJh5PzCmoOO3lPlMK+yhmAZF+sygW6GM7JMuE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Zk9L+mYJy8MQ+sgVYf+u0BptlSAUoWTM3qhOn68rSdwMG6PSlsXeT+cGrbN/FcOgYGefGBKw+yu9rznYI91eUrZrX66yo4fi5/cDhCDc/v6CSw8h2qmbAe1UnLjRg+iM/8j/WScr8uk74smkjlOB1Uw+Abpczgj/jbZl8Zc9fgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vXWPkZEr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tyq2ECWL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Apr 2025 13:33:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743687222;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WD2lwRD2xoE4T5/VDFj2y6MWPqikrSb15l90TdbEyQI=;
	b=vXWPkZEr8u0ze6HDQvpH698O7Gv/sNwftew8F99ETnyrOiVZn9XnjtQv6MD4SK9pS5CwaA
	FKIYG2RGRrKCqE5qYdq8M08xZ6p/ulCQomvvIL0o8RgzAIf87L//rhqM77y0QTQYRCGPLC
	1r0bVmtDzNnKGkylEkzGsCzTLsemBKtFMoojCUxhhTBT2FPCwWKk4Z75KVu0p8LlhVtlIl
	Dg1fELkB5238kkXGGi41uO5VmzxDjRaDmB+Cjz6wnwROr5bWRR+P3n//RMDGYz7roLCtox
	2nhc4siIolByJeDlnS8AONrqCxEZK6x9Lejpvx8pUvCmbOpWqWly9PQ8Z/0vlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743687222;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WD2lwRD2xoE4T5/VDFj2y6MWPqikrSb15l90TdbEyQI=;
	b=Tyq2ECWLhr0g4r6dij2QlAUUMf9597KR7a51XvJv1R1JI/rpHJBN7YbywXQomRxZlwMRIq
	p+tsds1TQx51GsAQ==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/nmi] x86/nmi: Fix comment in unknown_nmi_error()
Cc: Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Kai Huang <kai.huang@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250327234629.3953536-6-sohil.mehta@intel.com>
References: <20250327234629.3953536-6-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174368722144.30396.10503289275192821137.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/nmi branch of tip:

Commit-ID:     b4bc3144c1eca9107f45018000a1e68bfd308d8c
Gitweb:        https://git.kernel.org/tip/b4bc3144c1eca9107f45018000a1e68bfd308d8c
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Thu, 27 Mar 2025 23:46:25 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Apr 2025 22:26:11 +02:00

x86/nmi: Fix comment in unknown_nmi_error()

The comment in unknown_nmi_error() is incorrect and misleading. There
is no longer a restriction on having a single Unknown NMI handler. Also,
nmi_handle() never used the 'b2b' parameter.

The commits that made the comment outdated are:

  0d443b70cc92 ("x86/platform: Remove warning message for duplicate NMI handlers")
  bf9f2ee28d47 ("x86/nmi: Remove the 'b2b' parameter from nmi_handle()")

Remove the old comment and update it to reflect the current logic.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/r/20250327234629.3953536-6-sohil.mehta@intel.com
---
 arch/x86/kernel/nmi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index cdfb386..2a07c9a 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -327,10 +327,9 @@ unknown_nmi_error(unsigned char reason, struct pt_regs *regs)
 	int handled;
 
 	/*
-	 * Use 'false' as back-to-back NMIs are dealt with one level up.
-	 * Of course this makes having multiple 'unknown' handlers useless
-	 * as only the first one is ever run (unless it can actually determine
-	 * if it caused the NMI)
+	 * As a last resort, let the "unknown" handlers make a
+	 * best-effort attempt to figure out if they can claim
+	 * responsibility for this Unknown NMI.
 	 */
 	handled = nmi_handle(NMI_UNKNOWN, regs);
 	if (handled) {

