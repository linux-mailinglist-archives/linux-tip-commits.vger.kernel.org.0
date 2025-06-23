Return-Path: <linux-tip-commits+bounces-5882-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B495AE418E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Jun 2025 15:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F5A47A3E39
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Jun 2025 13:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F68C24C084;
	Mon, 23 Jun 2025 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NY4+5QNk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SnHwC87F"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5F2233D8E;
	Mon, 23 Jun 2025 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750683889; cv=none; b=lGucXEbp8s2aoJ52RgZc/dryc914qpFqgDgbLKQ4F3jtFs3DcKdAPcW/hxEWVu2oAwFffWR0Dq60DV8pDGdDe+uguHrGVxL68sUGrBLug86ZQgjdreKzwqr4sgbNENA1AvwVn2wAExmiHu2MS3RO3G73KQe1HXRrfYUkmPWN9zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750683889; c=relaxed/simple;
	bh=IcVDVIEVnMniqE+f7HOSKFLJjcOETkHWFISnstNUUdw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lpMXaOfUk9sML6NDqb08lk9OEb4WWjBaO42CqP40ItKyPCy4ZzwTRzvqRxJqRJo/FAR0nDrHa1gxW98R1m7xREyHaU9S1XiARKaOkBbSq9DBj4ah/hA0fJUqtLdku0poEBDUj9+dqPIWao4h3eQXEFs5eUCI0jJismnyw947ZuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NY4+5QNk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SnHwC87F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 23 Jun 2025 13:04:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750683885;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5UXqQvG4a6/F+TuYlrZefJQ7hcnrAo0Sa9rhsY95+u4=;
	b=NY4+5QNkOUR7uw16mZ8bEOoOQ+jBihNlHN9shYGLb1VpNtSEsJprP7Mv2biUxVJnKukNxw
	KLoRY+tbHYBZe21g67ZXmAhWGKPwe67rgxjEE3W0lVYXTu+aXZDHKZg8KkZ7Xukuxz+KPw
	XaSMLX283pN3KNcIBlE6luuRAWPxDWt5HoCsVjXgEyw54bYFfN6K+Le8+qvPGmAvtlY8kD
	lnLMwPwZI0Xey2WrAxVELIqDogEWTw8LtUNOtTFXA5TRiqBfuQl6E+9lr/IiJfzcdS9Ppw
	cYaKbjOU/MgQpcyIzILFZPKHH6Cdi+ge4G0+lh0XxzrgC0jx3CU1rY3SGmggIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750683885;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5UXqQvG4a6/F+TuYlrZefJQ7hcnrAo0Sa9rhsY95+u4=;
	b=SnHwC87FUBT3sSM09s8qZSXH8wiMQ+f56FqHWfTANBeCpm2KdKREcukQHmOlzofk5oJESW
	JlBgiw5DSRYcI8BA==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/urgent] futex: Initialize futex_phash_new during fork().
Cc: Calvin Owens <calvin@wbinvd.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250623083408.jTiJiC6_@linutronix.de>
References: <20250623083408.jTiJiC6_@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175068388403.406.13726507646292269621.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     a24cc6ce1933eade12aa2b9859de0fcd2dac2c06
Gitweb:        https://git.kernel.org/tip/a24cc6ce1933eade12aa2b9859de0fcd2dac2c06
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 23 Jun 2025 10:34:08 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 23 Jun 2025 14:50:37 +02:00

futex: Initialize futex_phash_new during fork().

During a hash resize operation the new private hash is stored in
mm_struct::futex_phash_new if the current hash can not be immediately
replaced.

The new hash must not be copied during fork() into the new task. Doing
so will lead to a double-free of the memory by the two tasks.

Initialize the mm_struct::futex_phash_new during fork().

Closes: https://lore.kernel.org/all/aFBQ8CBKmRzEqIfS@mozart.vkv.me/
Fixes: bd54df5ea7cad ("futex: Allow to resize the private local hash")
Reported-by: Calvin Owens <calvin@wbinvd.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Calvin Owens <calvin@wbinvd.org>
Link: https://lkml.kernel.org/r/20250623083408.jTiJiC6_@linutronix.de
---
 include/linux/futex.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index 005b040..b371936 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -89,6 +89,7 @@ void futex_hash_free(struct mm_struct *mm);
 static inline void futex_mm_init(struct mm_struct *mm)
 {
 	RCU_INIT_POINTER(mm->futex_phash, NULL);
+	mm->futex_phash_new = NULL;
 	mutex_init(&mm->futex_hash_lock);
 }
 

