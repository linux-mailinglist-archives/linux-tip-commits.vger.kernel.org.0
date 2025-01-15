Return-Path: <linux-tip-commits+bounces-3252-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BCFA11F0A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 11:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FF10188D558
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4C62361DA;
	Wed, 15 Jan 2025 10:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TvyQRTNI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wz2FJnIC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DC020B1F5;
	Wed, 15 Jan 2025 10:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736936119; cv=none; b=THOEQ0oG66nUznBgioayPOAAxKlR+3FoPwJ+daoPo6M9SsM9rgoNvsvm/fniKXXrFFba6/ML05K9t1V/eM7N4eLuk/tFNzeTH9dp0ojNccvVBVXLm63Ag1AGXMXOzaCN8gzvBdlzTgYIEcPimQS5VwR2ekGkOZTe90n+XMucZU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736936119; c=relaxed/simple;
	bh=FtPHvbBXAz602HvRRppvnwgWYbl/zXOaiuQDfYpQ7k0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Nn4k9/AA7yp+xWhmRrYLjRDNXI28NBH+eYxx/gkHSobZYse6uYL0QDYGwEkhDpSq8VkcptBuBXoelgSbiBG+ZsWxySUDFjZvzeXpN7uUjXs+a8UZRYySl1O/A0ISW/nGyTKK7wClTBNJtjaKwpirGD7uIeV8jd6WBs57uR9pixc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TvyQRTNI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wz2FJnIC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 10:15:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736936116;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DWetuv3B46Tn5+9Yydjk8DHNaQH3CWA5ujzvq+HKV/4=;
	b=TvyQRTNIv1VgNjEIOTmkIpOjc9qqi/M9mprsMmSD6K3jEWY6FWOotoFMu7CP8rhKMpno08
	pdbyM+JUx5RansDk72Z/KMpzcKBfl13oc8Tnd2pXZc6j1nH5vbZELEgL5SqkaXRM3ozRXy
	ytL9hcnjgqqmVkzu7VlOULmFRiayRRyFCtA/YqiM3gfMvLIACULso4JObJZ00zp/7Iwmoq
	T6J6q2J1T7Wole9gYR5n9T+yd2rXVM7gEFUQtDaLLIoS198lDPSKH86oB0sDyblN4+wILA
	gosccB6mDQz6ejOTgvZB1zny0Zkms98KXqavHZ3jaOKbauonXXBVeWvy3WI+fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736936116;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DWetuv3B46Tn5+9Yydjk8DHNaQH3CWA5ujzvq+HKV/4=;
	b=Wz2FJnICXAWzKwwTw6rbpL9bzWVI1HwMn9x93+pnoXpzYqoiE1/wWut/gWzIcgXQ3eXi4R
	aoAmxQdxZPPh2ZAg==
From: "tip-bot2 for Haiyue Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] vdso: Correct typo in PAGE_SHIFT comment
Cc: Haiyue Wang <haiyuewa@163.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241228121518.80812-1-haiyuewa@163.com>
References: <20241228121518.80812-1-haiyuewa@163.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693611553.31546.11864081457574235827.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     763d1ebec843b5048761e094281281abbd9a75f0
Gitweb:        https://git.kernel.org/tip/763d1ebec843b5048761e094281281abbd9a75f0
Author:        Haiyue Wang <haiyuewa@163.com>
AuthorDate:    Sat, 28 Dec 2024 20:15:08 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 15 Jan 2025 11:07:08 +01:00

vdso: Correct typo in PAGE_SHIFT comment

Signed-off-by: Haiyue Wang <haiyuewa@163.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241228121518.80812-1-haiyuewa@163.com

---
 include/vdso/page.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/vdso/page.h b/include/vdso/page.h
index 710ae24..bc47186 100644
--- a/include/vdso/page.h
+++ b/include/vdso/page.h
@@ -8,7 +8,7 @@
  * PAGE_SHIFT determines the page size.
  *
  * Note: This definition is required because PAGE_SHIFT is used
- * in several places throuout the codebase.
+ * in several places throughout the codebase.
  */
 #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
 

