Return-Path: <linux-tip-commits+bounces-2411-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C016399F164
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 17:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8497C28163C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 15:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355D81DD0DD;
	Tue, 15 Oct 2024 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R+TIZDWN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FrO4qB9O"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853DF1B393C;
	Tue, 15 Oct 2024 15:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006580; cv=none; b=pTfoejTtzW+9d6hNS3k6Ec7OI/DM+Cn+zcXgGCODKxbpHK3BnAanPeumhvxEMzYLtz0iHYZuSB/CeX4j0DjHbjDGQor00xfuVdSkQKD6B6BwqfBnSTKAtgS8jpyXPyh4SW1LjO26m9AHAvSAYeiTl2iSROf9tJeWacj9RScY3tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006580; c=relaxed/simple;
	bh=iggalwrtZmlbnQLqtQf/GgTIAR5aLhNXwUZviblTxg4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JYTt8EjM/xaf2qVoM5j4BvLcqaXTaM+ij3bGTJjgh3x26/BgdKc+BKuGTJ+rNnvs964rU/w9JUJOUEbrwnD87rXL9yH0lRUCuxwvqewnb5bNhGxDgJpXyP+QuGOLb61rBCp4nAMANMXEiBNFxdlm1RCLCV0j9txlcODY4enwC/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R+TIZDWN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FrO4qB9O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 15:36:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729006576;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3HkP2yDb2FvnOSHyH/EcWillIqE5aMsDdoxj2yLrhss=;
	b=R+TIZDWNgUW3ETljlokVHhOmop/jEA69Sl5IKQeEoP/T6zY1htMC7ZbqkO3qC+R7zh09IA
	5s7tSKEOAAYAZpTOx3s5O2ykGT9qCJJhSJUgcZ+Qn4k4mlRkrHgJTipsKiaVvq1bZoWd58
	N0+ajZHuGHuqaI2IuHdJf4xLW4KYWRqJdSaoDYNs80tI6YRjcGBScef3NF19b/83XNatBB
	nouHCjn2Rn93pkP9rpuY0KqfZP1nKhTUHlANCaaA3vIs4dtauJiQOUDQ8qwBnONBkZdodC
	dvUwb67Mf7b2+doMqcjW/dJ+XTWxbZQJYlFsLQR+pXJbyJFU7Szym5boHyN5Cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729006576;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3HkP2yDb2FvnOSHyH/EcWillIqE5aMsDdoxj2yLrhss=;
	b=FrO4qB9ObliVVIMYQDQUk6uRdEI++Z+Z2+oOYYyuCpvKl4yMUV3qU1IVdNBoOBj/w7GNWp
	gjgRTJbFunhSzZBQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/debugobjects] debugobjects: Double the per CPU slots
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Zhen Lei <thunder.leizhen@huawei.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241007164914.378676302@linutronix.de>
References: <20241007164914.378676302@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172900657594.1442.11562256490085665535.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     a201a96b9682e5b42ed93108c4aeb6135c909661
Gitweb:        https://git.kernel.org/tip/a201a96b9682e5b42ed93108c4aeb6135c909661
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 07 Oct 2024 18:50:19 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Oct 2024 17:30:33 +02:00

debugobjects: Double the per CPU slots

In situations where objects are rapidly allocated from the pool and handed
back, the size of the per CPU pool turns out to be too small.

Double the size of the per CPU pool.

This reduces the kmem cache allocation and free operations during a kernel compile:

     	     alloc    	    free
Baseline:    380k           330k
Double size: 295k	    245k

Especially the reduction of allocations is important because that happens
in the hot path when objects are initialized.

The maximum increase in per CPU pool memory consumption is about 2.5K per
online CPU, which is acceptable.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
Link: https://lore.kernel.org/all/20241007164914.378676302@linutronix.de

---
 lib/debugobjects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index cf704e2..fc9397d 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -28,7 +28,7 @@
 #define ODEBUG_POOL_SIZE	(64 * ODEBUG_BATCH_SIZE)
 #define ODEBUG_POOL_MIN_LEVEL	(ODEBUG_POOL_SIZE / 4)
 
-#define ODEBUG_POOL_PERCPU_SIZE	(4 * ODEBUG_BATCH_SIZE)
+#define ODEBUG_POOL_PERCPU_SIZE	(8 * ODEBUG_BATCH_SIZE)
 
 #define ODEBUG_CHUNK_SHIFT	PAGE_SHIFT
 #define ODEBUG_CHUNK_SIZE	(1 << ODEBUG_CHUNK_SHIFT)

