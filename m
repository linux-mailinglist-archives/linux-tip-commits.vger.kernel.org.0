Return-Path: <linux-tip-commits+bounces-2212-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6085971D56
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 16:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 746262840C3
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Sep 2024 14:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0217F1BC074;
	Mon,  9 Sep 2024 14:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NZTv9jA6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hZyv1vfs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C87C1BBBEC;
	Mon,  9 Sep 2024 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725893966; cv=none; b=ILKqogXW9LJoNXu2UodXzPrtxXwJsEI4fIG5sBudfriabYbOqkUBM9KyUJtdXb5Ty/0Nq7o/PDDQ/T2cAykQJkM5GwIcpMcR+v2VzEMkWc4M1DaLCet8QdrbBIaOpwvuooO0dCaX45AdeXyjI7d89u2u9+JUkfwELsJLqzP5K6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725893966; c=relaxed/simple;
	bh=Z6sR8fjg2pBXQo75zazGmZ5+4iK+fSnf1Ae1m9qQmrc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DSchLihGVXTUHd9N3MeMahF2CRDhHXEgKYssQ/ugoTlUVvZxeCbC/P9/UUw0hcFsBUDVyHwpJQp+e9xZMarvsi2b6EXZYHao+U5zsL0uvVt43JQ/Sf+TTjkp7heFrL0X6hGATV1j2E7OQq0Gus88VZZ5ER5p/aXMCuq/mThg70c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NZTv9jA6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hZyv1vfs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Sep 2024 14:59:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725893963;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c80oYamQG2uT6yTzdWn7QC4Lyxk/oOAaQ+j9UP1Cefo=;
	b=NZTv9jA6u6lTNTtqgEvWZkcUnWoDdUc7RFQZqCuJ5+Chowl+/hEyrv5lkuATiiMotelo8z
	4FqZCGRmDu6Dq4PM3iUkW5T8648Aqs9CDyTMs7AbWxTWkMSkIs9nmtfN3vxWokX5bziv9P
	e6pQ7LCiq0cRETueiVMUTncJ7OIOXNxFkjIaKXHMrbLOe038iO17dAIytnU/pm+6UDKoR1
	b+Lw+HEU4aJ2ao+6Uoe5/17vFPkWWI14oUdJreGMmTaBMKgazCS6kwrdl7xo3tVHDUlffa
	GAdO5rniTVNELoYpyB116687aTjd+Njh6C5RzbOFqutpu/ZjnlQ9C+FOfWUT2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725893963;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c80oYamQG2uT6yTzdWn7QC4Lyxk/oOAaQ+j9UP1Cefo=;
	b=hZyv1vfsATcTp5hgcDl/D+N+ZEzZIknSMs3j79lDuY+0Wc2ThkXusXD4KhxY6IfR1DYRuF
	P/cdpOzymQfDjMAg==
From: "tip-bot2 for Zhen Lei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/debugobjects] debugobjects: Fix the compilation attributes
 of some global variables
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Zhen Lei <thunder.leizhen@huawei.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240904133944.2124-2-thunder.leizhen@huawei.com>
References: <20240904133944.2124-2-thunder.leizhen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172589396315.2215.10252001791260543898.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     e4757c710ba27a1d499cf5941fc3950e9e542731
Gitweb:        https://git.kernel.org/tip/e4757c710ba27a1d499cf5941fc3950e9e542731
Author:        Zhen Lei <thunder.leizhen@huawei.com>
AuthorDate:    Wed, 04 Sep 2024 21:39:39 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 09 Sep 2024 16:40:25 +02:00

debugobjects: Fix the compilation attributes of some global variables

1. Both debug_objects_pool_min_level and debug_objects_pool_size are
   read-only after initialization, change attribute '__read_mostly' to
   '__ro_after_init', and remove '__data_racy'.

2. Many global variables are read in the debug_stats_show() function, but
   didn't mask KCSAN's detection. Add '__data_racy' for them.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240904133944.2124-2-thunder.leizhen@huawei.com
---
 lib/debugobjects.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 7cea91e..7226fdb 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -70,10 +70,10 @@ static HLIST_HEAD(obj_to_free);
  * made at debug_stats_show(). Both obj_pool_min_free and obj_pool_max_used
  * can be off.
  */
-static int			obj_pool_min_free = ODEBUG_POOL_SIZE;
-static int			obj_pool_free = ODEBUG_POOL_SIZE;
+static int __data_racy		obj_pool_min_free = ODEBUG_POOL_SIZE;
+static int __data_racy		obj_pool_free = ODEBUG_POOL_SIZE;
 static int			obj_pool_used;
-static int			obj_pool_max_used;
+static int __data_racy		obj_pool_max_used;
 static bool			obj_freeing;
 /* The number of objs on the global free list */
 static int			obj_nr_tofree;
@@ -84,9 +84,9 @@ static int __data_racy			debug_objects_fixups __read_mostly;
 static int __data_racy			debug_objects_warnings __read_mostly;
 static int __data_racy			debug_objects_enabled __read_mostly
 					= CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT;
-static int __data_racy			debug_objects_pool_size __read_mostly
+static int				debug_objects_pool_size __ro_after_init
 					= ODEBUG_POOL_SIZE;
-static int __data_racy			debug_objects_pool_min_level __read_mostly
+static int				debug_objects_pool_min_level __ro_after_init
 					= ODEBUG_POOL_MIN_LEVEL;
 
 static const struct debug_obj_descr *descr_test  __read_mostly;
@@ -95,8 +95,8 @@ static struct kmem_cache	*obj_cache __ro_after_init;
 /*
  * Track numbers of kmem_cache_alloc()/free() calls done.
  */
-static int			debug_objects_allocated;
-static int			debug_objects_freed;
+static int __data_racy		debug_objects_allocated;
+static int __data_racy		debug_objects_freed;
 
 static void free_obj_work(struct work_struct *work);
 static DECLARE_DELAYED_WORK(debug_obj_work, free_obj_work);

