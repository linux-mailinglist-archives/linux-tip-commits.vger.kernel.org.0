Return-Path: <linux-tip-commits+bounces-3012-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECC59E7881
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 20:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A6F6188827B
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 19:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395F51D515D;
	Fri,  6 Dec 2024 19:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OecV1iRV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R0LRo6sT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C41C22069F;
	Fri,  6 Dec 2024 19:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733511713; cv=none; b=Uos9/YMcTM21ESIJWULU87qgAoLMph+CxqAUKfu15JEH6TBrtnt20JTVYwV/usLNm3d5kBqAuJeig5wapRRCEDaYdX04hG2f3GVAPcZIuOkO3cdIOMA6f7e34R6O6h3bGu8t2hRN5B4nZqIdKxuVYzfFcT3XzGjcsLfvzXDxmLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733511713; c=relaxed/simple;
	bh=eFwv+m5RvwIlDg7kH5l+Y2uH8SJFPDp324PgI4NS+T4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZRzeOOl7I2nsB1/lqTqCc5ChIS5Iz8Hxnw9ePfHHb4VO4VBdKNvypstDaqHfYTJRGtDyJjZKsBYIDvGWOPlJkuvG+j+v7/AMgAXSt53kIsSBbyQ1mmPhuPj6rmKrRQhCtAWVtfz7DATO1vf+l7QyBv2rEKD3ZwZDPp8ARBKAQRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OecV1iRV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R0LRo6sT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Dec 2024 19:01:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733511709;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9KhBg/0Qt9zWMgCEucU/t1XKq7XTbMigX5k6S0wBW9c=;
	b=OecV1iRV2aBAJlj3BfKQljkhr4KLpjHcONtBWo1XzwtQbZffKBTD3z9TrqjUJHQi9y6ROr
	azeJ/T/O7Ye9dwDNXtdfMY7o4QCXTVQEevvaXg84O+vWJaxI2mimQ9gWHh4H1n1C+MdkdS
	dMp0/k94UJxqJws6qSYH4/YEBNNrpHmz4mQom4W+lZwu0RaPYenc25Qh4EIX1aRFFCkXj4
	bn80FuOEr7tp2VkGs/nrhVkJ/1sRvCtAFdVMTkiZKnfoFCIiNSpRqHIV0i629C5ZdLMwTj
	IFcVTzDF9oWBE7cKqIFudi5surVH/a8OGeibVUgct1rSey90HJuXXrfdZF3MVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733511709;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9KhBg/0Qt9zWMgCEucU/t1XKq7XTbMigX5k6S0wBW9c=;
	b=R0LRo6sTgAYwoQv+g2PLTCxIW+JweJw7dup6Sgiqq9kPovDuxhFnyR//PqBU4k1esGE5Fg
	QhiG22MQiaiG5PBg==
From: "tip-bot2 for Andrii Nakryiko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes: Guard against kmemdup() failing in
 dup_return_instance()
Cc: Andrii Nakryiko <andrii@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241206183436.968068-1-andrii@kernel.org>
References: <20241206183436.968068-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173351170826.412.8773509875179863982.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     64fb80679287a6dd0acd9c8afa259054a2479a52
Gitweb:        https://git.kernel.org/tip/64fb80679287a6dd0acd9c8afa259054a2479a52
Author:        Andrii Nakryiko <andrii@kernel.org>
AuthorDate:    Fri, 06 Dec 2024 10:34:36 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Dec 2024 19:52:47 +01:00

uprobes: Guard against kmemdup() failing in dup_return_instance()

If kmemdup() failed to alloc memory, don't proceed with extra_consumers
copy.

Fixes: e62f2d492728 ("uprobes: Simplify session consumer tracking")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20241206183436.968068-1-andrii@kernel.org
---
 kernel/events/uprobes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 1af9502..1f75a2f 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2048,6 +2048,8 @@ static struct return_instance *dup_return_instance(struct return_instance *old)
 	struct return_instance *ri;
 
 	ri = kmemdup(old, sizeof(*ri), GFP_KERNEL);
+	if (!ri)
+		return NULL;
 
 	if (unlikely(old->cons_cnt > 1)) {
 		ri->extra_consumers = kmemdup(old->extra_consumers,

