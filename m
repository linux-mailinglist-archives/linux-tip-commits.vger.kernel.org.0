Return-Path: <linux-tip-commits+bounces-5581-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3686ABA042
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 17:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E93169E4582
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 15:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43BA15E5D4;
	Fri, 16 May 2025 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fvZMxuAc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0xJReZjU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399A75661;
	Fri, 16 May 2025 15:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747410518; cv=none; b=o1Tmg4NNyATC7XAU4XwJ8rque9jxTZ/3JyKvS1hWDso+M3N/wLRLKRLFRpjUalbzdxo2dQ7tzS+DUYw9GjOy5QezO/sHDXnpqV3xiTw5bMkIo7wVf17P3PzThJwnqjJThpC9zJvysM/NqHUnTWtGCJt0WAHIf5I9LK2xB/sukts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747410518; c=relaxed/simple;
	bh=4yMasbm5F2D522We+YwsedBsKgRMIliDwjKsRn9gphg=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=QrhQH+uMa05aEaC/Hw8FTiXbaEpVYzthZ91xy5+AUiZKxGG/3hkNB6YnyhOVUi64AZbxs82l8/Pcj6kM2HB/j72VCFfvc1BJaZX6nhy/ihxQNQpMuY6j+pinDgsOOWhCCQ1J1POOFx+dLCIKqMFQxW/t5/j+E+Fi4jkTTxOUqGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fvZMxuAc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0xJReZjU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 15:48:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747410515;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=hgge4HhhXxyrPI3FhKC2KCKVMaw2xM2oKM+p5LaSYP0=;
	b=fvZMxuAc812kW+js3gpISzsRPS7wNgXOIi1Mc/8QnaAvGC98IPRrOOOj1wiIV2upOInMHR
	QOD7r67byJQNfm24rTK0BGhVEOhjYbX/GPq4f/bCrCQ8tm+Zcy37liAs/Cpsy0nbROJuBL
	9ZaGg8HMnJhIjWgIcwjMfDYFxertH3WrohW8ZWhZiBL1VG/T3shuUmZjSlCYNMplsnKlF/
	2L16dFApLa8TctXQguqmgmJYnq59W724CAX/8ph8Q+R3yw68DsB36Ya1OYAvfL5h6QsLBX
	iZtsTTYZ/j+Vu3OjLpaiISYehCMRf+uLKkluvOHQsKMfK/pnv+I8Ibg96EhTzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747410515;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=hgge4HhhXxyrPI3FhKC2KCKVMaw2xM2oKM+p5LaSYP0=;
	b=0xJReZjUeBSQzadgU1QDYtv6pbaViw+eJDaDCmql+sBpaNitVw78z0va3zgMFgn8LMNCMM
	Mvul3tFHgI4guiAw==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/bugs: Fix indentation due to ITS merge
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174741051403.406.11257957809384086628.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     4375decf50f74878e73c29c9dcd8af51dd3f7376
Gitweb:        https://git.kernel.org/tip/4375decf50f74878e73c29c9dcd8af51dd3f7376
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 16 May 2025 16:31:38 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 16 May 2025 17:39:12 +02:00

x86/bugs: Fix indentation due to ITS merge

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index dd8b50b..d1a03ff 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2975,10 +2975,10 @@ static void __init srso_apply_mitigation(void)
 
 		if (boot_cpu_data.x86 == 0x19) {
 			setup_force_cpu_cap(X86_FEATURE_SRSO_ALIAS);
-				set_return_thunk(srso_alias_return_thunk);
+			set_return_thunk(srso_alias_return_thunk);
 		} else {
 			setup_force_cpu_cap(X86_FEATURE_SRSO);
-				set_return_thunk(srso_return_thunk);
+			set_return_thunk(srso_return_thunk);
 		}
 		break;
 	case SRSO_MITIGATION_IBPB:

