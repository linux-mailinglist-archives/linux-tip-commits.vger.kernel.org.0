Return-Path: <linux-tip-commits+bounces-2161-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DC596BB5D
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Sep 2024 13:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01571F21BEF
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Sep 2024 11:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E3A1D096C;
	Wed,  4 Sep 2024 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SwWxXRw1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xGF5KwmN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55211D2225;
	Wed,  4 Sep 2024 11:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725451143; cv=none; b=Hds2WOVdqANfwg8CX/RCvRHA5Kpzu+a/lwBgdS09ZBDeubtycRRS/nHrltvrR9ot6lh33LbB5VGvtBOZmQbI0ps7vdGcSv7SkjuPQWr0XVsY2O8eoeiF/6UPE7JYPd2sEBjN+6BqjoKvMDUaOq0+vPkSiqH+VQNYrTIUzuK1eTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725451143; c=relaxed/simple;
	bh=zgLkYgK2uP4vGHdwouDRLgVoXVSDjxswoWNw6/yVG2U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=md8vEM1bDL+jbrY//lAF6uyv/Zql0OR4gKA3EVQd6iniUjgvwb3cU8o269YUYI7BRmwbYnzTPmy305/iSyXvvu4n1Dy03S/GaPnnuoqBk13wdZPY73PlaGRwp1ngyRKgFbOtocGXod+pBs3/WxXWHOET6U3XT2IGGHmMoBLzqOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SwWxXRw1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xGF5KwmN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Sep 2024 11:58:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725451134;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qR3EzyFpoXlvskosvjp1zWZUd42OA7Td85q9X3bkRRM=;
	b=SwWxXRw19Godg7ZhPwfsMW/UZ7lf/RcKkeIdYBSVqcxkllRwQSTscssV89dXJlQd1RDjXT
	I9LWYg9uyT/1OPD+fbYfpiLvTbcz7jWfQwM79BVoUs5Me/muKecBnJLdi0BDCWDKLoDE8G
	2U1LaKxs6kofS1xhNXjFLqp/AEbwg+/HGx3f2AVb79GMq4QIg7Zu7eYK3/fAku2EZ3zNa0
	y7GkHdCVylvi9L2EzjoDbq2rgv+7Iniz4EcoIoovxoLnfxj7DBBSA7uNH/a7ZJNpJcInnp
	cmWzIXJOWIjNo2+7xphHtlmuoDJ7FlGBodRYiPO70sMNCQlum3bV7NCmbkFOIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725451134;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qR3EzyFpoXlvskosvjp1zWZUd42OA7Td85q9X3bkRRM=;
	b=xGF5KwmN23IeGS9Szc08Sf4bVVTAkmxCHoJ6V2IBYWPBjSzXdnxI3vUq8KB4V4D4ANmTKg
	zw0Y01wQneZyZfAg==
From: "tip-bot2 for Sven Schnelle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] uprobes: Use kzalloc to allocate xol area
Cc: Sven Schnelle <svens@linux.ibm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240903102313.3402529-1-svens@linux.ibm.com>
References: <20240903102313.3402529-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172545113382.2215.7451184896946009553.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     e240b0fde52f33670d1336697c22d90a4fe33c84
Gitweb:        https://git.kernel.org/tip/e240b0fde52f33670d1336697c22d90a4fe33c84
Author:        Sven Schnelle <svens@linux.ibm.com>
AuthorDate:    Tue, 03 Sep 2024 12:23:12 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 03 Sep 2024 16:54:02 +02:00

uprobes: Use kzalloc to allocate xol area

To prevent unitialized members, use kzalloc to allocate
the xol area.

Fixes: b059a453b1cf1 ("x86/vdso: Add mremap hook to vm_special_mapping")
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20240903102313.3402529-1-svens@linux.ibm.com
---
 kernel/events/uprobes.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 73cc477..50d7949 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1489,7 +1489,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 	struct xol_area *area;
 	void *insns;
 
-	area = kmalloc(sizeof(*area), GFP_KERNEL);
+	area = kzalloc(sizeof(*area), GFP_KERNEL);
 	if (unlikely(!area))
 		goto out;
 
@@ -1499,7 +1499,6 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 		goto free_area;
 
 	area->xol_mapping.name = "[uprobes]";
-	area->xol_mapping.fault = NULL;
 	area->xol_mapping.pages = area->pages;
 	area->pages[0] = alloc_page(GFP_HIGHUSER);
 	if (!area->pages[0])

