Return-Path: <linux-tip-commits+bounces-3023-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9539E9038
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 11:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB4DC281CDF
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 10:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422362185A1;
	Mon,  9 Dec 2024 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dUrP3E2T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9n8N691D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51881217679;
	Mon,  9 Dec 2024 10:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740342; cv=none; b=CEmHzVV78SJlhjjZc4kJh+Y4qGcEr+rc8d+JfHnfP+g5w994i1ph1O5FxVI/SWPtLkkCXICvS2K8dADXxwOcF/RZIUec/ugXR1dxXTb4rI+q5TDTLZee9g98zLfBVrrleIgugHBz89pz7kn3QpEWvsbniGbh4TGYh+DHx7zWArs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740342; c=relaxed/simple;
	bh=7pyE5tv2qHm9XpfLKi0UdgV7Cag2Ruve7egx0vZqcv0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SDyM0YL5QOUE42meDndB6Fei1aUbRb8gKBej1DGQhqw94xIhSLjLkzAPvf+B9edxqWdNA3sKoTSEfgBP/tlclLoUEmCANweVEMuJwbJ+H1N2wXkf48HJCxsN10/4NwZd2gD1+UAeNItyOMRhnIq1WjGOSF7x29KcqXqMe36OeHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dUrP3E2T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9n8N691D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Dec 2024 10:32:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733740331;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DibnpxqiFxOycl1C6i0vo/MCwJezLHqdHW0SJGR8xEQ=;
	b=dUrP3E2TlE5mtilIEiTTCHrauQ+6FW33/ums+yIBcG4J1V2p3OnS4jvJzQh+4rEHWKZsnk
	M0TVG7T+yW10TYjutW3RII/TdX2VdOzKUXZayQCU+y1J5JU3yHz+gN1bC0FCW0cGNqf396
	UGdkR3w+nSrDyRHlst+em1VcLZLPn5k67Bembkz1AF8gFK1Eu9JZ+B28D1Q60eP30dNtZI
	yx5W0LouvJDirsawZsEuRI/sWhsg5WhiG6QIHxGcWSinRAvC+4zPZsPDjqzX32W6wp54NS
	Y9laaXoh/h8ujflvHnDmFLfo7u+wXZjn7oO+8asjieEvnVX6Y2u5ymhQMLksTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733740331;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DibnpxqiFxOycl1C6i0vo/MCwJezLHqdHW0SJGR8xEQ=;
	b=9n8N691DROx5/5cyf6auZLxD5eHm4zP+GvE/ddFr9n3lF5Nepw4gZ4c0goCgZ7cd4k3DfR
	MPc8IuVNt9g6B1Bw==
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
Message-ID: <173374033102.412.8428117769218808923.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     4621928fabc474d0ccab9e91f13b6f9f344e8248
Gitweb:        https://git.kernel.org/tip/4621928fabc474d0ccab9e91f13b6f9f344e8248
Author:        Andrii Nakryiko <andrii@kernel.org>
AuthorDate:    Thu, 05 Dec 2024 16:24:16 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Dec 2024 11:18:08 +01:00

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

