Return-Path: <linux-tip-commits+bounces-2652-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D67F99B6C50
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Oct 2024 19:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D52FB2113E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Oct 2024 18:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE17D13A27D;
	Wed, 30 Oct 2024 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IB8Degks";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4y5BaFYw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37D21BD9F1;
	Wed, 30 Oct 2024 18:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730314342; cv=none; b=lk8TLxjGdbR6e/QjuBn9U71tufIcmFUvjHidJPGwSE4WJ5GcJztcsGZmYwv28v7uWJuLOJtE2qWAutqk/NrRd2qyJOfB/fy49I92dh6mDxWNZWvx1sEO3CCvUKtpDUvVeHv9ZzmnATpMDcnAPmrJx2O/1OdUGzmLreuf4hLNKEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730314342; c=relaxed/simple;
	bh=y8lFIgy8LvpfbzjeuL9QrPl9tbF9syJv0VBzXOKXqoI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ku7/YoB4CPukBzRXp6BWryTh0OJNU8ufilqQxjp9UhjLqqvaPQTYoEBFApymwgRElPi/D0sP3M+GK7ODDxUtH0VX9gmlTST6oTy88jiTKEOAT/19aaOt4dTrjjkWjk58M6QkfGmIvRXSb7QDrtHO1b0bPpvA+ERyujTif+TPVrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IB8Degks; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4y5BaFYw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 30 Oct 2024 18:52:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730314338;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kxxx8p0XKtu8bVbEDpeAhQxkcC7JFjewS7Nf0CWll4M=;
	b=IB8DegksEebQGFkTdcqEZSBbTdQZsVZw6yMkqse2RUFAkmJ1DvQsKOK1aL1Feb2ftG+zfY
	R+Dx9Hb+T2aTASMFUVn01OH7VDorOboti/i8doYghib7BMR3mLWHx/NYT3O+Lyc74c4ppC
	enI723gefnyXcgMAWHY/kvPGmnrZEsAgMSq2H/9zvmPMFqbzZx8ajohv5bRAqBbknRaj0Z
	i3XgWuyT9JXgm0VUV8ea3aFX7aG+hvhHhLHrq2JyVPa3TPUpr16eS4gSNoSEAabjMqSR6a
	iJZ6h17p1/tRnwkTNwqgJVmHo1tZpwvTAiK3YPoIWaGz0+PGotoaDpKMqHobrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730314338;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kxxx8p0XKtu8bVbEDpeAhQxkcC7JFjewS7Nf0CWll4M=;
	b=4y5BaFYwlvgNkI8yAaxgj7WTyQFARhbdJl6RNPJQevmImer92O6hf05Kqi2+RUaNgnyIdP
	MY9tKuTEgSTI07AQ==
From: "tip-bot2 for Easwar Hariharan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] jiffies: Define secs_to_jiffies()
Cc: Michael Kelley <mhklinux@outlook.com>,
 Easwar Hariharan <eahariha@linux.microsoft.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20241030-open-coded-timeouts-v3-1-9ba123facf88@linux.microsoft.com>
References:
 <20241030-open-coded-timeouts-v3-1-9ba123facf88@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173031433772.3137.8495312302559502216.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b35108a51cf7bab58d7eace1267d7965978bcdb8
Gitweb:        https://git.kernel.org/tip/b35108a51cf7bab58d7eace1267d7965978bcdb8
Author:        Easwar Hariharan <eahariha@linux.microsoft.com>
AuthorDate:    Wed, 30 Oct 2024 17:47:35 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 30 Oct 2024 19:47:20 +01:00

jiffies: Define secs_to_jiffies()

secs_to_jiffies() is defined in hci_event.c and cannot be reused by
other call sites. Hoist it into the core code to allow conversion of the
~1150 usages of msecs_to_jiffies() that either:

 - use a multiplier value of 1000 or equivalently MSEC_PER_SEC, or
 - have timeouts that are denominated in seconds (i.e. end in 000)

It's implemented as a macro to allow usage in static initializers.

This will also allow conversion of yet more sites that use (sec * HZ)
directly, and improve their readability.

Suggested-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Link: https://lore.kernel.org/all/20241030-open-coded-timeouts-v3-1-9ba123facf88@linux.microsoft.com
---
 include/linux/jiffies.h   | 13 +++++++++++++
 net/bluetooth/hci_event.c |  2 --
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index 5d21dac..ed945f4 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -526,6 +526,19 @@ static __always_inline unsigned long msecs_to_jiffies(const unsigned int m)
 	}
 }
 
+/**
+ * secs_to_jiffies: - convert seconds to jiffies
+ * @_secs: time in seconds
+ *
+ * Conversion is done by simple multiplication with HZ
+ *
+ * secs_to_jiffies() is defined as a macro rather than a static inline
+ * function so it can be used in static initializers.
+ *
+ * Return: jiffies value
+ */
+#define secs_to_jiffies(_secs) ((_secs) * HZ)
+
 extern unsigned long __usecs_to_jiffies(const unsigned int u);
 #if !(USEC_PER_SEC % HZ)
 static inline unsigned long _usecs_to_jiffies(const unsigned int u)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 1c82dcd..4bd94d4 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -42,8 +42,6 @@
 #define ZERO_KEY "\x00\x00\x00\x00\x00\x00\x00\x00" \
 		 "\x00\x00\x00\x00\x00\x00\x00\x00"
 
-#define secs_to_jiffies(_secs) msecs_to_jiffies((_secs) * 1000)
-
 /* Handle HCI Event packets */
 
 static void *hci_ev_skb_pull(struct hci_dev *hdev, struct sk_buff *skb,

