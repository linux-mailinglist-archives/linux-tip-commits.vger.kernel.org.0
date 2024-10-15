Return-Path: <linux-tip-commits+bounces-2431-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3219099F18C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 17:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDDE71F27712
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 15:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C7D2296D4;
	Tue, 15 Oct 2024 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XTW6IqaX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zYWkbU5g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAEE2281F0;
	Tue, 15 Oct 2024 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006593; cv=none; b=u/mil9ryYUdWGNwFEUMulXG7R43Uq0Y+9+mqaxpmb2xQHw6YOK3kYuMMfwU9297yiw6wbWFn69QCh/a76L4NPyn4EshbW4eWu/HpemRe5wuQvFx3n/XE8Av19OSEiy3XPZpKK1UPeH8WxHOQA3W6QrGXgy3kDJ1DaVckM+0uMvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006593; c=relaxed/simple;
	bh=ndqKHI7F/QtmjCvnqqeXqOOYG1ApmBSFDFQ1ghVZQgE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UsnPT/se7Yxf0y1IhGFGMS70qqEoSXi1MpBYeCszC7rFbinswSXVh1Ap4hmh/iIRdObB9/6rcjoqgZHMdozhndgKQVn1IfUm7Zy6rwUE8CHs52LS77EwJfUIEOo69zB7CcKtW9iHr6dVhMK/+YetoWQRse1EGFVXl20lw9IxX2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XTW6IqaX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zYWkbU5g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 15:36:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729006590;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yDb63z2lIl0nZJ0uxyX+eD9hEE0VIdyWc8/NyMmiqq0=;
	b=XTW6IqaX99NsYK26wKIi0sjhDwS8P9sUhJPvI0AMWGDmtltc9LRNFsP1pLxZrXWUjM3DMP
	NlvDruqTo1AjX6zm7JtMvjwYNtolk2htjcAzC8q3tWxvdjKq4vLLOoPrPxDjRdZWEX5P8P
	GbaZRaUU1bZsCGHhNe4Up3sW5FDp1rpL/B2JN1JfqH1IKpX6mBd0MToIuo3BiMB55YsW9x
	fuOshnkJDrt1MHv4OM6DrK3c2W0qL6tTlEaptrZtYxpvQHEh0CjGiWtJbDw579Bmj2hXdS
	pxQwOu5zOnjvX1npTAbDv2Di0QkyTjW1LUrU/+sYPy6bKP5Ic87R7b8Y3CoqOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729006590;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yDb63z2lIl0nZJ0uxyX+eD9hEE0VIdyWc8/NyMmiqq0=;
	b=zYWkbU5g7FjSCfS5ZipjQpMIWsqQwOlWJ4HfextRwY3g8iNGxj2+AB89me07TqNG284HAv
	vMFBk7JVigQNBUAQ==
From: "tip-bot2 for Zhen Lei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: core/debugobjects] debugobjects: Delete a piece of redundant code
Cc: Zhen Lei <thunder.leizhen@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240911083521.2257-2-thunder.leizhen@huawei.com>
References: <20240911083521.2257-2-thunder.leizhen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172900658932.1442.15852426163479944809.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     a0ae95040853aa05dc006f4b16f8c82c6f9dd9e4
Gitweb:        https://git.kernel.org/tip/a0ae95040853aa05dc006f4b16f8c82c6f9dd9e4
Author:        Zhen Lei <thunder.leizhen@huawei.com>
AuthorDate:    Mon, 07 Oct 2024 18:49:52 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Oct 2024 17:30:30 +02:00

debugobjects: Delete a piece of redundant code

The statically allocated objects are all located in obj_static_pool[],
the whole memory of obj_static_pool[] will be reclaimed later. Therefore,
there is no need to split the remaining statically nodes in list obj_pool
into isolated ones, no one will use them anymore. Just write
INIT_HLIST_HEAD(&obj_pool) is enough. Since hlist_move_list() directly
discards the old list, even this can be omitted.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240911083521.2257-2-thunder.leizhen@huawei.com
Link: https://lore.kernel.org/all/20241007164913.009849239@linutronix.de


---
 lib/debugobjects.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 5ce473a..df48acc 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -1325,10 +1325,10 @@ static int __init debug_objects_replace_static_objects(void)
 	 * active object references.
 	 */
 
-	/* Remove the statically allocated objects from the pool */
-	hlist_for_each_entry_safe(obj, tmp, &obj_pool, node)
-		hlist_del(&obj->node);
-	/* Move the allocated objects to the pool */
+	/*
+	 * Replace the statically allocated objects list with the allocated
+	 * objects list.
+	 */
 	hlist_move_list(&objects, &obj_pool);
 
 	/* Replace the active object references */

