Return-Path: <linux-tip-commits+bounces-5532-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE59AB6547
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 May 2025 10:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0693B3B1056
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 May 2025 08:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9943216386;
	Wed, 14 May 2025 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sf0dwxju";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e6IM9/wj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BFD21B9F6;
	Wed, 14 May 2025 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747210025; cv=none; b=L8jxExtP9D4oVM3MpJWOrAjOlWsZQ+z5QBgtIMqT2cpPBHaKgkeqFcjr7O8m6Xf66sf2Ezh8bG99+twhP0kNccqaImmBt5MyePn3DZWlxFn10tOfYOoaoIBNAqsFUrYyOlxa8OWoQk5qG6MeW50e9bcDL7Xu/kw0wTPSSNwURCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747210025; c=relaxed/simple;
	bh=dBrrxb0DwSBVussg9hHXfVQBDytRObDxD/hmg5mXip0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=i2ZFw8aIWyrVFfSp3J643P3KXCZ/Sjw54hCt49sCABPbodyGE3CruFPjvQHW+ifupfuDzlnky7ZQHTS0CjoqsysIytN8d5JZA6HCR44SpaASn0gQQFxbmwwmr6VV0uZMbujGeH22XKcDQMA/j1EaquQZ6Y4ZugACqvoINlcQZBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sf0dwxju; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e6IM9/wj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 May 2025 08:07:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747210022;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hl0M8tmJlVf/kLLhl/pqJiQmXqVNiA07SAjg5n+w+fI=;
	b=sf0dwxju0ZWvcGKwEzevpHYMOYr/KkCQlxHCwslwfUCKMCGpn7hOMNbVC5t6Boxw4F0oHF
	UAYicRZlRZ2GjPfLROGecq/XyJG9fyMlw0c2G0hbeE4KIZmg+8B2O65JbelWpTF+65xCQl
	wzM7coRkkC2RD1HiVJ/9rZn2nsH/IjtWwUxrELpkZuSDsS9GqcuMuqzRv+5DcmSM/j0s6Q
	3NXn0gKQdlDVW8p4fa9c7Hcpxmjl3iJYPD8LxX8yMjaxvJYzVjvSSOp4hMdVCi74BUctD1
	PpvWFh2D+NOsN2uJFoP9/9Dub6OO5bnYkQILpz8C/xdvUKFvQ7sVGVbzdaKC7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747210022;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hl0M8tmJlVf/kLLhl/pqJiQmXqVNiA07SAjg5n+w+fI=;
	b=e6IM9/wjKcRcYz+5Cw2oNIyRJ6Qz4RK+e9kkGhxujVl04y81xWsDL8Ph6+5Amgt8mRTPLL
	9BeRAcuJnribqeCA==
From: "tip-bot2 for Shivank Garg" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cleanups] x86/power: hibernate: Fix W=1 build kernel-doc warnings
Cc: Shivank Garg <shivankg@amd.com>, Ingo Molnar <mingo@kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250514062637.3287779-2-shivankg@amd.com>
References: <20250514062637.3287779-2-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174721002142.406.2035568473511213094.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     f449bf98b7b63702e86155fe5fa3c853c3bf1fda
Gitweb:        https://git.kernel.org/tip/f449bf98b7b63702e86155fe5fa3c853c3bf1fda
Author:        Shivank Garg <shivankg@amd.com>
AuthorDate:    Wed, 14 May 2025 06:26:38 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 14 May 2025 09:58:54 +02:00

x86/power: hibernate: Fix W=1 build kernel-doc warnings

Warnings generated with 'make W=1':

  arch/x86/power/hibernate.c:47: warning: Function parameter or struct member 'pfn' not described in 'pfn_is_nosave'
  arch/x86/power/hibernate.c:92: warning: Function parameter or struct member 'max_size' not described in 'arch_hibernation_header_save'

Add missing parameter documentation in hibernate functions to
fix kernel-doc warnings.

Signed-off-by: Shivank Garg <shivankg@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/r/20250514062637.3287779-2-shivankg@amd.com
---
 arch/x86/power/hibernate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
index 5b81d19..a7c23f2 100644
--- a/arch/x86/power/hibernate.c
+++ b/arch/x86/power/hibernate.c
@@ -42,6 +42,7 @@ unsigned long relocated_restore_code __visible;
 
 /**
  *	pfn_is_nosave - check if given pfn is in the 'nosave' section
+ *	@pfn: the page frame number to check.
  */
 int pfn_is_nosave(unsigned long pfn)
 {
@@ -86,7 +87,10 @@ static inline u32 compute_e820_crc32(struct e820_table *table)
 /**
  *	arch_hibernation_header_save - populate the architecture specific part
  *		of a hibernation image header
- *	@addr: address to save the data at
+ *	@addr: address where architecture specific header data will be saved.
+ *	@max_size: maximum size of architecture specific data in hibernation header.
+ *
+ *	Return: 0 on success, -EOVERFLOW if max_size is insufficient.
  */
 int arch_hibernation_header_save(void *addr, unsigned int max_size)
 {

