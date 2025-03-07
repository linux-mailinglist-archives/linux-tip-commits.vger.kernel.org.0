Return-Path: <linux-tip-commits+bounces-4057-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0583DA575EB
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 00:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78950189B29D
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Mar 2025 23:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D192E258CDF;
	Fri,  7 Mar 2025 23:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="stKjhNRv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B//fOggG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C103219E8;
	Fri,  7 Mar 2025 23:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741389694; cv=none; b=Mmusmqdc+L54dGnHhDx6f4AIZf6fMjaU8MKRuDWZ1KytgK5zWBHZ0Q3RkE94VfCKnbx2G2mnJpSRoJtPv9bKsCZZ0+e8hOr6Vn0YCvbDsb0XkM415NfLw1XLereF4WkdyiBSgqy3IGQAvdFdzGCArTr0sAq4ssD+etS95jamLu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741389694; c=relaxed/simple;
	bh=xdF4Coi8t6ioFlnnCVxfLvP45sOsP7ih0UV8SaalgC0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qD9i1EDWdTVpDVHufXs93m/CL6tq1LIgjQKTDrKutBzjcsCtxqeeS5HD7mVZCB3FcI6P8vpPpS7EX5Q866lgM0HTez30BWPohphv8EZsVEafra9BXAOOSyUnnDrA4dof6kFQmMzoek/QzKhp+w/YZsfjfYvL253jze92/1C2Duw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=stKjhNRv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B//fOggG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 07 Mar 2025 23:21:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741389690;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xLd+148MThUg2Gz4aNJysluLFeSRWK6160erUWfSWMk=;
	b=stKjhNRveeVM7znmaR7QQ28SfHEcoIk4TYMDc/4KhMVQN2jW22R1smDZq5c0M5FuWQqtAt
	T2Af4anG9e0mODFAlJw18lwcmg43KPmdbNEnNkFKaTIEzl96EGFCkIbrqeMGJcShW5I5Bh
	brfD86+v2FanXTr9ngRwvmZWBY93sD4cDAwqOhwCyK27DZ4bgqxcr9wl7NVBrbkpizhZoq
	Ir4GrSbfc2+TteQ4vFx6wQikRWLmJqnCtB9p/xh7HnNth7+CFP9U2iSHl1MZh+nBDpg/0Z
	NBCVKGQINcdh098WXCBkdtVGG2L6OJV4UVrWwEF5c0hHhy1E+mEhQOz3aATp8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741389690;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xLd+148MThUg2Gz4aNJysluLFeSRWK6160erUWfSWMk=;
	b=B//fOggGT4/QmxE1wjJ9M+a2NYc7LbIwfcfPpSv2F31mpUEDlaeRkaaAzxzGAwB0aTOVQW
	SY6dQRiEroJu3XBw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm: Define PTRS_PER_PMD for assembly code too
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <Z8oa8AUVyi2HWfo9@gmail.com>
References: <Z8oa8AUVyi2HWfo9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174138968981.14745.2513243286942332493.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     6914f7e2e25fac9d1d2b62c208eaa5f2bf810fe9
Gitweb:        https://git.kernel.org/tip/6914f7e2e25fac9d1d2b62c208eaa5f2bf810fe9
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 06 Mar 2025 23:00:16 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 08 Mar 2025 00:09:09 +01:00

x86/mm: Define PTRS_PER_PMD for assembly code too

Andy reported the following build warning from head_32.S:

  In file included from arch/x86/kernel/head_32.S:29:
  arch/x86/include/asm/pgtable_32.h:59:5: error: "PTRS_PER_PMD" is not defined, evaluates to 0 [-Werror=undef]
       59 | #if PTRS_PER_PMD > 1

The reason is that on 2-level i386 paging the folded in PMD's
PTRS_PER_PMD constant is not defined in assembly headers,
only in generic MM C headers.

Instead of trying to fish out the definition from the generic
headers, just define it - it even has a comment for it already...

Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/Z8oa8AUVyi2HWfo9@gmail.com
---
 arch/x86/include/asm/pgtable-2level_types.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/pgtable-2level_types.h b/arch/x86/include/asm/pgtable-2level_types.h
index 7f6ccff..4a12c27 100644
--- a/arch/x86/include/asm/pgtable-2level_types.h
+++ b/arch/x86/include/asm/pgtable-2level_types.h
@@ -23,17 +23,17 @@ typedef union {
 #define ARCH_PAGE_TABLE_SYNC_MASK	PGTBL_PMD_MODIFIED
 
 /*
- * traditional i386 two-level paging structure:
+ * Traditional i386 two-level paging structure:
  */
 
 #define PGDIR_SHIFT	22
 #define PTRS_PER_PGD	1024
 
-
 /*
- * the i386 is two-level, so we don't really have any
- * PMD directory physically.
+ * The i386 is two-level, so we don't really have any
+ * PMD directory physically:
  */
+#define PTRS_PER_PMD	1
 
 #define PTRS_PER_PTE	1024
 

