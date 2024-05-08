Return-Path: <linux-tip-commits+bounces-1245-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9748BF9BC
	for <lists+linux-tip-commits@lfdr.de>; Wed,  8 May 2024 11:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09480281BD5
	for <lists+linux-tip-commits@lfdr.de>; Wed,  8 May 2024 09:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3E03613C;
	Wed,  8 May 2024 09:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qaKuKohV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fEwUY9YG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32BD757FF;
	Wed,  8 May 2024 09:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715161545; cv=none; b=dN/IPgHEEZrsP+uZan27vaw7Is80JNtfF+ohVw67NNk25b2TiilJMJBvMJIfIpWqNAOQALysH8IQdIhdG3l6mzB/Wjx24ABup+Km9L+2f7usaTH6fZmZj25l2srXbYkQtrxoPg/nXwZYM/x2vY7PyKLjVj2V2FZR6rxrM+tRn3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715161545; c=relaxed/simple;
	bh=VvSbcq6zW2fnQWvkVQ5/q87Qren5Fb32JIxM1/7CRYA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QZYofxgTQFlO9ULXXiTQdhimTMQEZO7NGaWyeWwRrB2aSLR5oqepzeZ50OURqH9Gs7TlHauUpNHoTC5gwB5boufsaoJE4DPEMizvxD18B9S11j3bOrlUHQqHclcbYsnZO/jNSJXonxLZjjg9lDMmFXG62BbmP+sJe52MlZUFfdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qaKuKohV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fEwUY9YG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 08 May 2024 09:45:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715161541;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jWoo3PHXJABOe48yFCtj0VK6/apGVsCQvNtpubhPhOk=;
	b=qaKuKohVpoLPR1GbSHHiFBwSCXtytIcgVYz4VMHDozu0jAzpEiCKKAf3Cy5r0ODDl0IRPc
	JGTwoqKHBInJHg925dyfCZpM8EJw8kP/hXO0VtPdV18yTtsSr55O3f9TuGOer9qcqrJPMz
	8OsaoHFe3v81K//305Xb/KCu90O5KuN7xeX3iRvbYcKgLIV2AQeBTlcN8+svxUvPrLjpXe
	I4p7zvot07Zq5Y7sVX0SZM5VYXpO4Ot6SaRhTnVm3CHAHKVZP/aE4MyxKVJiJ/X/JqDpZV
	myZ7WqjUb+CH5eBnrI8jqLQV/4BX49+D4n5Gj+KWdb2MERSEJ2sTXZ92fn6ctQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715161541;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jWoo3PHXJABOe48yFCtj0VK6/apGVsCQvNtpubhPhOk=;
	b=fEwUY9YGUFBgP8mHvgLS7TNjjKkqKVaNVDqaqgQlsjcoOcM9YbZnww+cPTzEv/sPtXTyBA
	CqXNX/qWbJbnMxBg==
From: "tip-bot2 for Levi Yun" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timers/migration: Prevent out of bounds access
 on failure
Cc: Levi Yun <ppbuk5246@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240506041059.86877-1-ppbuk5246@gmail.com>
References: <20240506041059.86877-1-ppbuk5246@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171516154125.10875.14125964308560203288.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     d7ad05c86e2191bd66e5b62fca8da53c4a53484f
Gitweb:        https://git.kernel.org/tip/d7ad05c86e2191bd66e5b62fca8da53c4a53484f
Author:        Levi Yun <ppbuk5246@gmail.com>
AuthorDate:    Mon, 06 May 2024 05:10:59 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 08 May 2024 11:19:43 +02:00

timers/migration: Prevent out of bounds access on failure

When tmigr_setup_groups() fails the level 0 group allocation, then the
cleanup derefences index -1 of the local stack array.

Prevent this by checking the loop condition first.

Fixes: 7ee988770326 ("timers: Implement the hierarchical pull model")
Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Link: https://lore.kernel.org/r/20240506041059.86877-1-ppbuk5246@gmail.com
---
 kernel/time/timer_migration.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index ccba875..8441311 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1596,7 +1596,7 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 
 	} while (i < tmigr_hierarchy_levels);
 
-	do {
+	while (i > 0) {
 		group = stack[--i];
 
 		if (err < 0) {
@@ -1645,7 +1645,7 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 				tmigr_connect_child_parent(child, group);
 			}
 		}
-	} while (i > 0);
+	}
 
 	kfree(stack);
 

