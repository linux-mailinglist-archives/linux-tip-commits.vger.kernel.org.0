Return-Path: <linux-tip-commits+bounces-8214-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDZrESo3jGlwjQAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8214-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Feb 2026 09:00:42 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 956C6121FEA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Feb 2026 09:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29F0C30053DD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Feb 2026 08:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8809C21C16E;
	Wed, 11 Feb 2026 08:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u6FL/s7e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T09LhP8r"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFDA22339;
	Wed, 11 Feb 2026 08:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770796839; cv=none; b=paB0crQwMkS5vGPt/fkd5vmNfJnklDxU0jrx1gIQAvUdlKWhRcLMXVRF81OgVqGTQRRR6OFeh6+JSQD/Aaq2mBbneFfApKUTA9AzAxIufoy+I3neok/vrKsCY4Zhf/Dl4rrjlV0qG1a+QY1BW6/wZnlmxOQms/tf0EH8l4v9lbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770796839; c=relaxed/simple;
	bh=+lSe5UViLHdHmeJyzrNFnEN90DzA5PlTHITlRt2QFoo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=X4pKdCUvZOAyXgixSF9RlMmewIWGIsvNXhRzpOXK6yo+Rw6Fjy6skbaxQ9VaEV4/KRcWjDDwkZdBfsagqtGTN5xpDwqQrRwLg/bPekSPGPxuKhA0E0PYSZLa1FGe0URcNWBDImt9hfqRG1gil4yzYfMf8JyGG2FNG9MQsMdvhVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u6FL/s7e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T09LhP8r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Feb 2026 08:00:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770796836;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zp5TKKm6rKS+/4xv4ZoAwAYC+lJWwvta+Ykze0VTn0M=;
	b=u6FL/s7eaK8KuJ7NRB6u3MWn0FIJHYX5u4OKfjbRSpMUWLMpsIqT88+QCMNEZQDmjRKvJP
	wYvINVwIVx7M8MnzGAnjGgrierMCGOYIDEox77ySEzLFBBgiQT1jSxdhy3Kc4HlNVQBfT/
	FGZUo8l4mYG8rPEt3APVm6ieOvqygRs6uNr4XcId9UX/mw1cH5VNEOHC9vixggphlORYVy
	qqbUwlm67nx5/LyVSuHeXut0eIPAWUqf0u19SkUqh1DgP9FQW5oooRIuoa6gtNe3xq/Ct6
	WLB3cZoCJ2aSyaX9IFgmvT9VObbfmMzZCvdT0j1PW2iHVuWNvs4XTVKMRBVmig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770796836;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zp5TKKm6rKS+/4xv4ZoAwAYC+lJWwvta+Ykze0VTn0M=;
	b=T09LhP8rfrEUJD1RaT1PSQxOrtMXvkcDRMNA5NdkxwCjNFjtUZquDbn/EcNVL7l9Hbj54i
	WvUaX6NOzvHhpQCw==
From: "tip-bot2 for Eric Dumazet" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] time/jiffies: Inline jiffies_to_msecs() and
 jiffies_to_usecs()
Cc: Eric Dumazet <edumazet@google.com>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260210170226.57209-1-edumazet@google.com>
References: <20260210170226.57209-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177079683499.542.10702079878530904505.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8214-lists,linux-tip-commits=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[5];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 956C6121FEA
X-Rspamd-Action: no action

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     b777b5e09eabeefc6ba80f4296366a4742701103
Gitweb:        https://git.kernel.org/tip/b777b5e09eabeefc6ba80f4296366a47427=
01103
Author:        Eric Dumazet <edumazet@google.com>
AuthorDate:    Tue, 10 Feb 2026 17:02:25=20
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Wed, 11 Feb 2026 08:55:52 +01:00

time/jiffies: Inline jiffies_to_msecs() and jiffies_to_usecs()

For common cases (HZ=3D100, 250 or 1000), these helpers are at most one
multiply, so there is no point calling a tiny function.

Keep them out of line for HZ=3D300 and others.

This saves cycles in TCP fast path, among other things.

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/8 grow/shrink: 25/89 up/down: 530/-3474 (-2944)
...
nla_put_msecs                                193       -    -193
message_stats_print                         2131     920   -1211
Total: Before=3D25365208, After=3D25362264, chg -0.01%

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260210170226.57209-1-edumazet@google.com
---
 include/linux/jiffies.h | 40 ++++++++++++++++++++++++++++++++++++++--
 kernel/time/time.c      | 19 +++++++------------
 2 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index fdef2c1..d1c3d49 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -434,8 +434,44 @@ extern unsigned long preset_lpj;
 /*
  * Convert various time units to each other:
  */
-extern unsigned int jiffies_to_msecs(const unsigned long j);
-extern unsigned int jiffies_to_usecs(const unsigned long j);
+
+#if HZ <=3D MSEC_PER_SEC && !(MSEC_PER_SEC % HZ)
+/**
+ * jiffies_to_msecs - Convert jiffies to milliseconds
+ * @j: jiffies value
+ *
+ * This inline version takes care of HZ in {100,250,1000}.
+ *
+ * Return: milliseconds value
+ */
+static inline unsigned int jiffies_to_msecs(const unsigned long j)
+{
+	return (MSEC_PER_SEC / HZ) * j;
+}
+#else
+unsigned int jiffies_to_msecs(const unsigned long j);
+#endif
+
+#if !(USEC_PER_SEC % HZ)
+/**
+ * jiffies_to_usecs - Convert jiffies to microseconds
+ * @j: jiffies value
+ *
+ * Return: microseconds value
+ */
+static inline unsigned int jiffies_to_usecs(const unsigned long j)
+{
+	/*
+	 * Hz usually doesn't go much further MSEC_PER_SEC.
+	 * jiffies_to_usecs() and usecs_to_jiffies() depend on that.
+	 */
+	BUILD_BUG_ON(HZ > USEC_PER_SEC);
+
+	return (USEC_PER_SEC / HZ) * j;
+}
+#else
+unsigned int jiffies_to_usecs(const unsigned long j);
+#endif
=20
 /**
  * jiffies_to_nsecs - Convert jiffies to nanoseconds
diff --git a/kernel/time/time.c b/kernel/time/time.c
index 0ba8e3c..36fd231 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -365,20 +365,16 @@ SYSCALL_DEFINE1(adjtimex_time32, struct old_timex32 __u=
ser *, utp)
 }
 #endif
=20
+#if HZ > MSEC_PER_SEC || (MSEC_PER_SEC % HZ)
 /**
  * jiffies_to_msecs - Convert jiffies to milliseconds
  * @j: jiffies value
  *
- * Avoid unnecessary multiplications/divisions in the
- * two most common HZ cases.
- *
  * Return: milliseconds value
  */
 unsigned int jiffies_to_msecs(const unsigned long j)
 {
-#if HZ <=3D MSEC_PER_SEC && !(MSEC_PER_SEC % HZ)
-	return (MSEC_PER_SEC / HZ) * j;
-#elif HZ > MSEC_PER_SEC && !(HZ % MSEC_PER_SEC)
+#if HZ > MSEC_PER_SEC && !(HZ % MSEC_PER_SEC)
 	return (j + (HZ / MSEC_PER_SEC) - 1)/(HZ / MSEC_PER_SEC);
 #else
 # if BITS_PER_LONG =3D=3D 32
@@ -390,7 +386,9 @@ unsigned int jiffies_to_msecs(const unsigned long j)
 #endif
 }
 EXPORT_SYMBOL(jiffies_to_msecs);
+#endif
=20
+#if (USEC_PER_SEC % HZ)
 /**
  * jiffies_to_usecs - Convert jiffies to microseconds
  * @j: jiffies value
@@ -405,17 +403,14 @@ unsigned int jiffies_to_usecs(const unsigned long j)
 	 */
 	BUILD_BUG_ON(HZ > USEC_PER_SEC);
=20
-#if !(USEC_PER_SEC % HZ)
-	return (USEC_PER_SEC / HZ) * j;
-#else
-# if BITS_PER_LONG =3D=3D 32
+#if BITS_PER_LONG =3D=3D 32
 	return (HZ_TO_USEC_MUL32 * j) >> HZ_TO_USEC_SHR32;
-# else
+#else
 	return (j * HZ_TO_USEC_NUM) / HZ_TO_USEC_DEN;
-# endif
 #endif
 }
 EXPORT_SYMBOL(jiffies_to_usecs);
+#endif
=20
 /**
  * mktime64 - Converts date to seconds.

