Return-Path: <linux-tip-commits+bounces-2623-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5729B3272
	for <lists+linux-tip-commits@lfdr.de>; Mon, 28 Oct 2024 15:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80F511F2247B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 28 Oct 2024 14:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244DC1DD554;
	Mon, 28 Oct 2024 14:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="arGkzp+v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rkE9mDo2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B3C1DB922;
	Mon, 28 Oct 2024 14:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124226; cv=none; b=vEGTkDyALiwdWeMHieJQDYdmUbrHGra2A0RStWhJh6nDudycXZZOP9vZtM7O2fMXyUFliyYBP6OtbCVvR7aMvrdKGH0bBbVagoZamxKSU0OCx8vukYm8doZ0/CixB1gh/DzaQehjd5rVfP6HuKl/2J/n5s+4fYwyICbSeVBFg+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124226; c=relaxed/simple;
	bh=UO2Np97bbRmmRNH5U0frEn7d9SUxS8pzOMQSOzd+U5g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uDwHk4RFH5H8fRQlaPS/Cjnbjw4V8IQ7JCKqu3P5zfakiQLcNpjV9+3YsT9j006q/yQi/7gDmWXWvXS7gTZ0ZjdP7IQB66akm7YGAtilO15qcf7nyrKcn87e3ctCKg0I0C2i0jVsl65N4BS9BkXIxUoIeDuoyzASp/4aw2A2kCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=arGkzp+v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rkE9mDo2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 28 Oct 2024 14:03:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730124222;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HrSQiWQY0kHuSMxiycezsKXoS5qH797q8JxQRTQfWLQ=;
	b=arGkzp+vnkKPhuGaDPx1168RvCCo7vLNlQDugvD6IKCWAAI4TxaNWRZjLj+2gKMqG5bcrF
	v/Dzzr8ZC/HcDr9gbbxgvs/y+rGmM6dAKSSEuqNh5Wt/UNyUeh138VSx1269pTHIg7NwZp
	le3UXFZu4Nk0cX5dBYrzB5DqYVYMz3iDvh5p5MZpQ6pWIkD8e54mVE99Sozo1NwwHL2QJ2
	8oOqvexamLICjNMbxZUkScpQQb6dSGi80EBW0fFJDb4Wl+0VvAHU2cq1qTtuol1bI4uLkh
	iKbpatyH3ZvLUMJuNhhJKolNUvyJ3fchYf8M4RKVrmJKAOa7lT7MgkktVOWuXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730124222;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HrSQiWQY0kHuSMxiycezsKXoS5qH797q8JxQRTQfWLQ=;
	b=rkE9mDo2xIqlaWrlSftnNyfGZw08su8jlxuSFBMJ/6kdgdbEr+41njvltLl8+ZVwQenVPS
	7UmFMsjjoLZBNlBA==
From: "tip-bot2 for Qiuxu Zhuo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce/mcelog: Use xchg() to get and clear the flags
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tony Luck <tony.luck@intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
 Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241025024602.24318-2-qiuxu.zhuo@intel.com>
References: <20241025024602.24318-2-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173012422146.1442.7437515597289801002.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     325c3376afad838eec8b9342e9e5eef270c5b184
Gitweb:        https://git.kernel.org/tip/325c3376afad838eec8b9342e9e5eef270c5b184
Author:        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
AuthorDate:    Fri, 25 Oct 2024 10:45:53 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 28 Oct 2024 14:07:47 +01:00

x86/mce/mcelog: Use xchg() to get and clear the flags

Using xchg() to atomically get and clear the MCE log buffer flags,
streamlines the code and reduces the text size by 20 bytes.

  $ size dev-mcelog.o.*

       text	   data	    bss	    dec	    hex	filename
       3013	    360	    160	   3533	    dcd	dev-mcelog.o.old
       2993	    360	    160	   3513	    db9	dev-mcelog.o.new

No functional changes intended.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20241025024602.24318-2-qiuxu.zhuo@intel.com
---
 arch/x86/kernel/cpu/mce/dev-mcelog.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
index af44fd5..8d02323 100644
--- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -264,15 +264,8 @@ static long mce_chrdev_ioctl(struct file *f, unsigned int cmd,
 		return put_user(sizeof(struct mce), p);
 	case MCE_GET_LOG_LEN:
 		return put_user(mcelog->len, p);
-	case MCE_GETCLEAR_FLAGS: {
-		unsigned flags;
-
-		do {
-			flags = mcelog->flags;
-		} while (cmpxchg(&mcelog->flags, flags, 0) != flags);
-
-		return put_user(flags, p);
-	}
+	case MCE_GETCLEAR_FLAGS:
+		return put_user(xchg(&mcelog->flags, 0), p);
 	default:
 		return -ENOTTY;
 	}

