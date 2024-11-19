Return-Path: <linux-tip-commits+bounces-2873-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D789D24CC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 Nov 2024 12:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7D6AB267E4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 Nov 2024 11:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DB61C4A08;
	Tue, 19 Nov 2024 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l86g1tmP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5J0GVVGM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93221198A37;
	Tue, 19 Nov 2024 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732015660; cv=none; b=aOw1GwZpDd82jvH21Cf3V7jOtoJs5FSNL5sn/FpHesB+fEUMJTV2LKJHFeOV+NDZBje6U+KeZgnQtYjPhPMv7irOxAVzhx1eLu+w9tqWn0WF6Lerb5RFjKiGmLkWRnHDjXKLhNEyH5A5OdVKzf6lnQVhVzbAMyIcF/N5Q3mdAWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732015660; c=relaxed/simple;
	bh=M1MinBHQmUvyCiXRYGaRDXN+nNstRnOy9tmqksjv9zM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oN69IizkCnNks4tot+DzLHe3MCfIVGDyD97dfE61QSElQoz1dR4QYkMWKsK6478q7SU22zbkswJLDPKJaFacNjOTIAjqRlYIw7wHAFKG9XAvsWOPyqlEiP7LS25ef/i8C9F9+QZY0J7cEjniJ1iDG1Ga6ceP6HOshTtI9G2pNTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l86g1tmP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5J0GVVGM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 19 Nov 2024 11:27:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732015655;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fyM4OcXuPCtQxR65pXPHCIeW3mbMpc4/xmvpm0jK0Vo=;
	b=l86g1tmP/1R5fs8JtQ1De5bsf1JBCWZJmmullmb1maMH27Ku1rorly2SW2VbxpQ3R3g2Bd
	pa4ZnL6w3FvJvwysbMDKcI1403pInStvRCRMTfxPrXc8AqekERKZxfbe5k/1nVVn5Zhd7C
	7iVULmfXk9ESLuIOgeKwQ6/SfjLMqBvd6w8/ELCyAj6m2CUqDSMeEqKBJkRNOWumwnq2Y/
	fG+fX4Qn6ahrx/dHYsepiBfl2/Vs84Z4pc4f18rC8zhzKa8LqFcekRiwTdmWT+8tDohevZ
	8wWaD4qPhlaL6U9utVJtDp28N5Rhb0fw8X0vW/AsYyVkdUJaSALR8W29ylpKbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732015655;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fyM4OcXuPCtQxR65pXPHCIeW3mbMpc4/xmvpm0jK0Vo=;
	b=5J0GVVGMsnIfeCTYgr4ZWBLu0ZBr/dkAVYyy8xpD6tN1fg4yOao0fAEG/fgpEUd9supVbk
	+My52qVYZNblCGDg==
From: "tip-bot2 for Rik van Riel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/mm] x86/mm/tlb: Add tracepoint for TLB flush IPI to stale CPU
Cc: Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@surriel.com>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241114152723.1294686-3-riel@surriel.com>
References: <20241114152723.1294686-3-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173201565457.412.10419972628825414246.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     2815a56e4b7252a836969f5674ee356ea1ce482c
Gitweb:        https://git.kernel.org/tip/2815a56e4b7252a836969f5674ee356ea1ce482c
Author:        Rik van Riel <riel@surriel.com>
AuthorDate:    Thu, 14 Nov 2024 10:26:17 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 19 Nov 2024 12:02:46 +01:00

x86/mm/tlb: Add tracepoint for TLB flush IPI to stale CPU

Add a tracepoint when we send a TLB flush IPI to a CPU that used
to be in the mm_cpumask, but isn't any more.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20241114152723.1294686-3-riel@surriel.com
---
 arch/x86/mm/tlb.c        | 1 +
 include/linux/mm_types.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index cc4e57a..1aac4fa 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -760,6 +760,7 @@ static void flush_tlb_func(void *info)
 		/* Can only happen on remote CPUs */
 		if (f->mm && f->mm != loaded_mm) {
 			cpumask_clear_cpu(raw_smp_processor_id(), mm_cpumask(f->mm));
+			trace_tlb_flush(TLB_REMOTE_WRONG_CPU, 0);
 			return;
 		}
 	}
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6e3bdf8..6b6f054 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1335,6 +1335,7 @@ enum tlb_flush_reason {
 	TLB_LOCAL_SHOOTDOWN,
 	TLB_LOCAL_MM_SHOOTDOWN,
 	TLB_REMOTE_SEND_IPI,
+	TLB_REMOTE_WRONG_CPU,
 	NR_TLB_FLUSH_REASONS,
 };
 

