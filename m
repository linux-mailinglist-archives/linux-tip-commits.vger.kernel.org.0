Return-Path: <linux-tip-commits+bounces-1932-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BFF947AB1
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Aug 2024 13:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEDB21F2222D
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Aug 2024 11:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455CB1547D9;
	Mon,  5 Aug 2024 11:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FX78dAg/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DebsWebS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06656155CAB;
	Mon,  5 Aug 2024 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722858967; cv=none; b=uRXvK8zyeU6JVdfjFzvw/PR7eZjjiO0ysmFgBIJJxyJirgNnjDmq5EIg7zWV54d1yOZXm+TqyX/maX3zdS1Yw1cD8kDOYhpRtbg0jS2LyN33WptprvCui0x3Sr7nl87QtMoTX9qAa4faTgXr7P5+vHHQsmn9OHUeYM7rCsO3FJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722858967; c=relaxed/simple;
	bh=2uUCcNLw/joubHVbZfawPwkW1OZ7KDuhyxxW3HCkaWM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M3gTEsJfk78A2ZADzA+zXgylYkG79//AvhmnKyPa8nwqmLpHm5hbDGw6iLHiBpON0k2EEwMw8GJToSWCSUPUQ8sS5rmm2i0PToxgRiu7XdG66NURSl5TVdd7ifob8ZA4/QrKk47UWeFO6G3NM2tFXZeG00dHv1J6FPLNXy2DrVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FX78dAg/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DebsWebS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Aug 2024 11:56:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722858963;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vRHcQi3DOur0Ca32jcFImEC5Ur/lDGdi0+OjjyyCdIk=;
	b=FX78dAg/Z5lv2KxoGEYeSqfKliRSg/b9BtiVR+Od8KoOr7dg12hckpiBvpw0N9xC1OuMbE
	9/l+j0HAC+J9bfanSky7yw1W53OkF4XiYI89huEriS5pjR9exKL3h1Si2MmHhxUyTO3nnH
	93S1T8WSmCrU6Y+jPQcUcPQ9wKHfiadNlX2r/ojeGfrPhJ73d8D2hUiGkVH9TF91U2sL1w
	n3FaLw4D7E0AKX17AUMz38fJRlzVVOX4RET9hFV2b6hLbS/KFQLOAwzyHZAD8wqMLWSjAs
	RbEkb+b5BOzzOhwIvF+9fsL3gz5PtkYbuUNQYBWw8jCu7pLKkqDBtNe2Ka/TFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722858963;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vRHcQi3DOur0Ca32jcFImEC5Ur/lDGdi0+OjjyyCdIk=;
	b=DebsWebS04u2ckWwT4BIEpSNb2QZ2u3go1TkST89rSq2TnmgI+yVtKkJdVmDXJRma6pwds
	sz2ruSRmNfVECPAQ==
From: "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes: change uprobe_register() to use
 uprobe_unregister() instead of __uprobe_unregister()
Cc: Oleg Nesterov <oleg@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240801132739.GA8809@redhat.com>
References: <20240801132739.GA8809@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172285896306.2215.17089314186188760223.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     bb18c5de1c288050ef8bd4af4ca16896ad4cd3fc
Gitweb:        https://git.kernel.org/tip/bb18c5de1c288050ef8bd4af4ca16896ad4cd3fc
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Thu, 01 Aug 2024 15:27:39 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Aug 2024 11:30:32 +02:00

uprobes: change uprobe_register() to use uprobe_unregister() instead of __uprobe_unregister()

If register_for_each_vma() fails uprobe_register() can safely drop
uprobe->register_rwsem and use uprobe_unregister(). There is no worry
about the races with another register/unregister, consumer_add() was
already called so this case doesn't differ from _unregister() right
after the successful _register().

Yes this means the extra up_write() + down_write(), but this is the
slow and unlikely case anyway.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20240801132739.GA8809@redhat.com
---
 kernel/events/uprobes.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index b33f139..eacf287 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1174,16 +1174,18 @@ struct uprobe *uprobe_register(struct inode *inode,
 	if (likely(uprobe_is_active(uprobe))) {
 		consumer_add(uprobe, uc);
 		ret = register_for_each_vma(uprobe, uc);
-		if (ret)
-			__uprobe_unregister(uprobe, uc);
 	}
 	up_write(&uprobe->register_rwsem);
 	put_uprobe(uprobe);
 
-	if (unlikely(ret == -EAGAIN))
-		goto retry;
+	if (ret) {
+		if (unlikely(ret == -EAGAIN))
+			goto retry;
+		uprobe_unregister(uprobe, uc);
+		return ERR_PTR(ret);
+	}
 
-	return ret ? ERR_PTR(ret) : uprobe;
+	return uprobe;
 }
 EXPORT_SYMBOL_GPL(uprobe_register);
 

