Return-Path: <linux-tip-commits+bounces-2425-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FB999F17F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 17:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC991C2256A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 15:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B9F20C477;
	Tue, 15 Oct 2024 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="csXKYgdM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gXJuOEz8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3432E1FAEF5;
	Tue, 15 Oct 2024 15:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006588; cv=none; b=cQWfHHZIqlYJrEeRaDTrThc1bF1G0Whdyi6SoXZJQfRrPkyJEO/byaya3jhSsgkkZgs9XQ3uKvkRURCKewkYS5k/DfrR5GXMTSYDYKilrQEc/QKjPys5k9sfr6Snw2PnrY4tbVNlnwhidEq9swxbYTWExwz6inE0GZCO0dwk3BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006588; c=relaxed/simple;
	bh=fTZ93vQFHuh9rLwjTLbQTZ0zCqTqhjqoKnyDu7Q0Cms=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=l3aj5xWgSuqNPbn/KQu76e7w08zh7HDethYKiBZsteEGwvL+UwAxebC2roQN6PLXrxDTpdBthInTUlrh3JRR0N3odMRHlw05VlCjV1M+JOqpSN3H9XoVMmd+QKNHLuZ+ypjja8qvIIJS93fHCcPbZdqmKvZv22mqrLe3sTFEG+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=csXKYgdM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gXJuOEz8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 15:36:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729006585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p5mBk3oYz4Ru4jX1ir2slSipA2LgzsMvJl3VvdeRCJ0=;
	b=csXKYgdMBoAYFxJM+/kb0RaMySt//9FjTfwyYco24a7aGjm649RMiEEzAv6H3qoudvZWTv
	CB+iAKy3q5Bya9VZhZ/BQrECi0jBIi0ZiSfYg0dn6Brw6UPuGplGXGwRfJ+PehFv6uxFl6
	olC86VipAnQl3ku1iIJpMLSNCDo8EmgM7+qqqv1Og/M2Aeno/V2u4zZGhjS6Q3E3m5S7vX
	E6LcMn3DmvESg/zw3WnV11aPQ5DItFxQU2N9t+ke3yZc/2+z1jWLLkt/eUl2OCgD4VPkl0
	wyeT6Mf2zFeMf8H67MX+0HAk7Ut/wvFA3Y1pY24sXt3mIiMpXlmnTf+/zfgREQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729006585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p5mBk3oYz4Ru4jX1ir2slSipA2LgzsMvJl3VvdeRCJ0=;
	b=gXJuOEz8nc2EAg5uE5zSYZdP14nYbcJj8z0yMWBql49ceKYzRwytF19351IcfZ6kh5L88L
	r5taPMbati5cH1BQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: core/debugobjects] debugobjects: Make debug_objects_enabled bool
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Zhen Lei <thunder.leizhen@huawei.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241007164913.518175013@linutronix.de>
References: <20241007164913.518175013@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172900658455.1442.9931938637990283612.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     661cc28b523d4616a322c8f82f06ec7880192060
Gitweb:        https://git.kernel.org/tip/661cc28b523d4616a322c8f82f06ec7880192060
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 07 Oct 2024 18:50:02 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Oct 2024 17:30:31 +02:00

debugobjects: Make debug_objects_enabled bool

Make it what it is.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
Link: https://lore.kernel.org/all/20241007164913.518175013@linutronix.de

---
 lib/debugobjects.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 6ccdfeb..0d69095 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -82,7 +82,7 @@ static int __data_racy			debug_objects_maxchain __read_mostly;
 static int __data_racy __maybe_unused	debug_objects_maxchecked __read_mostly;
 static int __data_racy			debug_objects_fixups __read_mostly;
 static int __data_racy			debug_objects_warnings __read_mostly;
-static int __data_racy			debug_objects_enabled __read_mostly
+static bool __data_racy			debug_objects_enabled __read_mostly
 					= CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT;
 static int				debug_objects_pool_size __ro_after_init
 					= ODEBUG_POOL_SIZE;
@@ -103,17 +103,16 @@ static DECLARE_DELAYED_WORK(debug_obj_work, free_obj_work);
 
 static int __init enable_object_debug(char *str)
 {
-	debug_objects_enabled = 1;
+	debug_objects_enabled = true;
 	return 0;
 }
+early_param("debug_objects", enable_object_debug);
 
 static int __init disable_object_debug(char *str)
 {
-	debug_objects_enabled = 0;
+	debug_objects_enabled = false;
 	return 0;
 }
-
-early_param("debug_objects", enable_object_debug);
 early_param("no_debug_objects", disable_object_debug);
 
 static const char *obj_states[ODEBUG_STATE_MAX] = {
@@ -592,7 +591,7 @@ static struct debug_obj *lookup_object_or_alloc(void *addr, struct debug_bucket 
 	}
 
 	/* Out of memory. Do the cleanup outside of the locked region */
-	debug_objects_enabled = 0;
+	debug_objects_enabled = false;
 	return NULL;
 }
 
@@ -1194,7 +1193,7 @@ check_results(void *addr, enum debug_obj_state state, int fixups, int warnings)
 out:
 	raw_spin_unlock_irqrestore(&db->lock, flags);
 	if (res)
-		debug_objects_enabled = 0;
+		debug_objects_enabled = false;
 	return res;
 }
 
@@ -1278,7 +1277,7 @@ out:
 	descr_test = NULL;
 
 	local_irq_restore(flags);
-	return !!debug_objects_enabled;
+	return debug_objects_enabled;
 }
 #else
 static inline bool debug_objects_selftest(void) { return true; }
@@ -1372,7 +1371,7 @@ void __init debug_objects_mem_init(void)
 				  SLAB_DEBUG_OBJECTS | SLAB_NOLEAKTRACE, NULL);
 
 	if (!cache || !debug_objects_replace_static_objects(cache)) {
-		debug_objects_enabled = 0;
+		debug_objects_enabled = false;
 		pr_warn("Out of memory.\n");
 		return;
 	}

