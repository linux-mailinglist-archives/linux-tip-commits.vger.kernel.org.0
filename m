Return-Path: <linux-tip-commits+bounces-3043-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 136D29E9998
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 15:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E458166717
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 14:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D761E9B12;
	Mon,  9 Dec 2024 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n23nXiyf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r3bBfnfo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5811BEF84;
	Mon,  9 Dec 2024 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733756122; cv=none; b=qlqr7kfrZz6XO12K8uFqaQDShc8oCDH8MnK6sS3vELHyOj8kCPhyzDjWMeVR2kZrztm8vWBHdLF4dZqjBPotdrtFAuRbweGL0VQUmNz9s0l3Ix6NLCB5hOgsAh6/R2xcikkfFmdZ3NteNHEkecwVek+/QhBNJ4I3WCs0amuG6CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733756122; c=relaxed/simple;
	bh=1R5eVfqCLdGKh3Bm0eeYAt/Z+v8buDdQKJBBBGtNMjY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ibbFsaox8hSUakw8sriS6u4E2dGNRaiOSAAn+8+0yzAmc/hNrvxSyekQhbolly8UqiIx/NHVCaCqCnEVBgrobigsZhL68RreGm6v6tbU19IANl9eTQ8LdI7BxWvko31ekBBuQLPmMZn9kSW2iznIjqc3hgmyJiPxPQyPsczjodw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n23nXiyf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r3bBfnfo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Dec 2024 14:55:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733756119;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5pedds+RSW8anpZDqdlgNThMy228Bjs9yUTt3v0Vxz8=;
	b=n23nXiyf6cO42zSK/igVZJTWXrdo+WXPdJ/c+sIgg2HWx3wDBkZtviynyP7GdCy2c3KVV6
	DihcBTVU/KTZLzLiFkHpHeLo1oY2vl9FAPfJvF4FC/rEmxB0MOkU2fRuvV90ZxWAfLnqz8
	Ihm/YPYMcoMZWgQKQPtpncLi0wojsNFTBo7mE4M3uT3APEhtEabBK9BlxEkFExs50DXkif
	znz/iQxshtGGqwID4l+zLw+NFUwxCMjdpVfDQuRPoCHlemYByTYWDnQh+ho8Nva2mQNTTP
	IVeWpg0ciLPiIjiAQMTp/lIKsIvafe10mf6gpUEd2xeEgnZxCLtNUki3muviWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733756119;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5pedds+RSW8anpZDqdlgNThMy228Bjs9yUTt3v0Vxz8=;
	b=r3bBfnfoQMqaQ1iD58OWxdhEOQp3sdF2XDaDIjp6yNliJNDwrf+dRA4P0FeI8mLN9cGION
	wuIcuPl4Cttqo0Dw==
From: "tip-bot2 for Andrii Nakryiko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes: Ensure return_instance is detached from the
 list before freeing
Cc: Andrii Nakryiko <andrii@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241206002417.3295533-4-andrii@kernel.org>
References: <20241206002417.3295533-4-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173375611879.412.16108769035605460165.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     0cf981de7687b26ccc9bd4e6daa8fa6b177f91a9
Gitweb:        https://git.kernel.org/tip/0cf981de7687b26ccc9bd4e6daa8fa6b177f91a9
Author:        Andrii Nakryiko <andrii@kernel.org>
AuthorDate:    Thu, 05 Dec 2024 16:24:16 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Dec 2024 15:50:29 +01:00

uprobes: Ensure return_instance is detached from the list before freeing

Ensure that by the time we call free_ret_instance() to clean up an
instance of struct return_instance it isn't reachable from
utask->return_instances anymore.

free_ret_instance() is called in a few different situations, all but one
of which already are fine w.r.t. return_instance visibility:

  - uprobe_free_utask() guarantees that ri_timer() won't be called
    (through timer_delete_sync() call), and so there is no need to
    unlink anything, because entire utask is being freed;
  - uprobe_handle_trampoline() is already unlinking to-be-freed
    return_instance with rcu_assign_pointer() before calling
    free_ret_instance().

Only cleanup_return_instances() violates this property, which so far is
not causing problems due to RCU-delayed freeing of return_instance,
which we'll change in the next patch. So make sure we unlink
return_instance before passing it into free_ret_instance(), as otherwise
reuse will be unsafe.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20241206002417.3295533-4-andrii@kernel.org
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index cca1fe4..2345aeb 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2116,12 +2116,12 @@ static void cleanup_return_instances(struct uprobe_task *utask, bool chained,
 
 	while (ri && !arch_uretprobe_is_alive(ri, ctx, regs)) {
 		ri_next = ri->next;
+		rcu_assign_pointer(utask->return_instances, ri_next);
 		utask->depth--;
 
 		free_ret_instance(ri, true /* cleanup_hprobe */);
 		ri = ri_next;
 	}
-	rcu_assign_pointer(utask->return_instances, ri);
 }
 
 static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs,

