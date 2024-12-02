Return-Path: <linux-tip-commits+bounces-2939-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B85AB9E0032
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D12A280D01
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264A920B1F6;
	Mon,  2 Dec 2024 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hW3JWAdI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lVL8YPTz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355C41FECAE;
	Mon,  2 Dec 2024 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138126; cv=none; b=rkA1LCqaRDi42APWP3rDBNtU2AOHaxRw3bYJIVB+LasGSXbVK2tk0JLgkoRAncz9cWOlV6HCzZh8DMP1nJTrpZqW5+JZU/5+EjW1uoeOrNPZrk8QNnefYLC9cTq4Ba5O9wrur1M4zn4VrukQz9hMabbcf3zW+puBEr12xq1efh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138126; c=relaxed/simple;
	bh=g933LIcm6DHHVutyxuFFfyPrrAuJuS5/8MyNjHT0BS8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JYrnOjS4oVyhqKUgj/ZWvpNkPvWJQogGPMk6wlMIPShLwCw5jsFPjlUgIMI5a7S1mz/7YM+QDXHWWlmfVzLZ5JSfKO+eFRwDosyf6NX5n2E1WHtESvXiEHNbqb8coupGlQZPoWx+/KKUFOmHkkHqbxC3c7vFcumZHdfzvhKe8j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hW3JWAdI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lVL8YPTz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:15:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138122;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MTMU2x4c7ehpzBBlBY+cW0mE/xALOKaOJJfYgDhGACg=;
	b=hW3JWAdIuN2nlMQ9dTe8u63ln3SpUst4ymbxlhs/Ecno5XXFrihS5jRswM8mIGKDPMU+fJ
	JmosE07bCsazWw5q+rnWbT1zA76pgalLs2nkMQdy6FEWT785JPjEF0dEqiy39Mm5/J7xuZ
	UWBy3PP/As3H7r+zxcKqrxbUvfDfMVp+4AXUXT/wqbgfWuTW27wIVqa5HWY7E1Drh2jakj
	Jc4FsbE1+x4AcnJGRD/ZbIr8yc1WnAhKqcEwAFc/oC1NwZUo+qd4IOopHR9INNOCAtuPD+
	cakRwOlfcRBRPbna2lO5yUj2mYDzFwLEUBNw01f+olNbUOwoOYdxIyp4lDBaDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138122;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MTMU2x4c7ehpzBBlBY+cW0mE/xALOKaOJJfYgDhGACg=;
	b=lVL8YPTztTzemmpVjrGWm7THysWVr8pkyA38CMkFzJlyvvGtAO/3J7fkKEqYe2qBA04BPO
	p5xxtL9/M2Q5m0AQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86: Convert unreachable() to BUG()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241128094312.028316261@infradead.org>
References: <20241128094312.028316261@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313812188.412.17754446990942244796.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     2190966fbc14ca2cd4ea76eefeb96a47d8e390df
Gitweb:        https://git.kernel.org/tip/2190966fbc14ca2cd4ea76eefeb96a47d8e390df
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 28 Nov 2024 10:39:02 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:43 +01:00

x86: Convert unreachable() to BUG()

Avoid unreachable() as it can (and will in the absence of UBSAN)
generate fallthrough code. Use BUG() so we get a UD2 trap (with
unreachable annotation).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20241128094312.028316261@infradead.org
---
 arch/x86/kernel/process.c | 2 +-
 arch/x86/kernel/reboot.c  | 2 +-
 arch/x86/kvm/svm/sev.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index f63f8fd..15507e7 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -838,7 +838,7 @@ void __noreturn stop_this_cpu(void *dummy)
 #ifdef CONFIG_SMP
 	if (smp_ops.stop_this_cpu) {
 		smp_ops.stop_this_cpu();
-		unreachable();
+		BUG();
 	}
 #endif
 
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 6159228..dc1dd3f 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -883,7 +883,7 @@ static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
 
 	if (smp_ops.stop_this_cpu) {
 		smp_ops.stop_this_cpu();
-		unreachable();
+		BUG();
 	}
 
 	/* Assume hlt works */
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 943bd07..fe6cc76 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3820,7 +3820,7 @@ next_range:
 		goto next_range;
 	}
 
-	unreachable();
+	BUG();
 }
 
 static int __sev_snp_update_protected_guest_state(struct kvm_vcpu *vcpu)

