Return-Path: <linux-tip-commits+bounces-2457-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E88A99FB83
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 00:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0EBE1F225B3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 22:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABA81D63F5;
	Tue, 15 Oct 2024 22:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RIFMVB54";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ChDW8gEx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEA71B0F32;
	Tue, 15 Oct 2024 22:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729032086; cv=none; b=q//tZ+sTyltFkDBaxVRDB5QEcv9VUS2TA0KrCIqEdBmvPQFaBma3+D1EaRnmyoIBNPal/Mv4gpHMuaBTPKI1KAi9x+nrje9n503vzAoDWD8lwIpg0oxkZC+TuB9z4fIsz//q0+4/lJc7u3dVkZ2vDTSRLf1hPsdU1XyxqbrsFu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729032086; c=relaxed/simple;
	bh=ijD70kU1WprQwPtDwVStD+cqpi8W2DrTSpa0yGCtrtc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qPqnUcEi+igwkd5GRqw9VnFHK68rf/HLdUQrAtlpyCf6NANw+LwLcSL0GN8+grY0o8LjGMQQKjTcloc1myEK4eZRjsc1lavmAzG/05Qa4C4N+ncwaJ8VAGHvnx7GQR9scbKIdhp1iN70oASg5y2FdnKcTOBIAueIePzBq7GTF8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RIFMVB54; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ChDW8gEx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 22:41:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729032081;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cknx4W1PtmGxricpF7tlJitVRoioSu+p+Q3Ei4qodVQ=;
	b=RIFMVB54zmlfPLET6FrMD0asrHu3IXNHXZniGyvY14SXHpMSLX/oHxpM4Y0WAEb+ryARNq
	NOv0IDIN2UTMIt9R8C3EaYX/sFKNGF1rFDQ/Jq845aSkHx+poDWVy51h7dBrfuhrunwINq
	Tirx2++GGYsfMlcGOIeviao1CJnOchC7r27nmGwc38mmp5iBxxn5cLsoaMCUVyL39ips5Y
	RzZE5RtBW3oOCuu5az1Sn5921yX4Uxm03sXfanzdIADQwKZWySf9kL7hBh1L3PJxSx4pC3
	UOuXCjRyIXxDic7wLEKQlsT9mqcf5Wk5zbiYV+fG5A2FqRm3LvCFmaqMv/FaUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729032081;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cknx4W1PtmGxricpF7tlJitVRoioSu+p+Q3Ei4qodVQ=;
	b=ChDW8gExvJfwLJZuTpZR0uQEip5mSdqAr+1Rf4hACZot0zWZMVLnjoG5KNlETdHBkRGJ4y
	aanWLpWSvr6xx8Ag==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] iopoll/regmap/phy/snd: Fix comment referencing
 outdated timer documentation
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, Andrew Lunn <andrew@lunn.ch>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20241014-devel-anna-maria-b4-timers-flseep-v3-12-dc8b907cb62f@linutronix.de>
References:
 <20241014-devel-anna-maria-b4-timers-flseep-v3-12-dc8b907cb62f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172903208103.1442.6781306923792665447.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     89124747f096fc0fe44be0162c7b4fb3271739e8
Gitweb:        https://git.kernel.org/tip/89124747f096fc0fe44be0162c7b4fb3271739e8
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 14 Oct 2024 10:22:29 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 00:36:47 +02:00

iopoll/regmap/phy/snd: Fix comment referencing outdated timer documentation

Function descriptions in iopoll.h, regmap.h, phy.h and sound/soc/sof/ops.h
copied all the same outdated documentation about sleep/delay function
limitations. In those comments, the generic (and still outdated) timer
documentation file is referenced.

As proper function descriptions for used delay and sleep functions are in
place, simply update the descriptions to reference to them. While at it fix
missing colon after "Returns" in function description and move return value
description to the end of the function description.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch> # for phy.h
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20241014-devel-anna-maria-b4-timers-flseep-v3-12-dc8b907cb62f@linutronix.de

---
 include/linux/iopoll.h | 52 ++++++++++++++++++++---------------------
 include/linux/phy.h    |  9 +++----
 include/linux/regmap.h | 38 +++++++++++++++---------------
 sound/soc/sof/ops.h    |  8 +++---
 4 files changed, 54 insertions(+), 53 deletions(-)

diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
index 19a7b00..91324c3 100644
--- a/include/linux/iopoll.h
+++ b/include/linux/iopoll.h
@@ -19,19 +19,19 @@
  * @op: accessor function (takes @args as its arguments)
  * @val: Variable to read the value into
  * @cond: Break condition (usually involving @val)
- * @sleep_us: Maximum time to sleep between reads in us (0
- *            tight-loops).  Should be less than ~20ms since usleep_range
- *            is used (see Documentation/timers/timers-howto.rst).
+ * @sleep_us: Maximum time to sleep between reads in us (0 tight-loops). Please
+ *            read usleep_range() function description for details and
+ *            limitations.
  * @timeout_us: Timeout in us, 0 means never timeout
  * @sleep_before_read: if it is true, sleep @sleep_us before read.
  * @args: arguments for @op poll
  *
- * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
- * case, the last read value at @args is stored in @val. Must not
- * be called from atomic context if sleep_us or timeout_us are used.
- *
  * When available, you'll probably want to use one of the specialized
  * macros defined below rather than this macro directly.
+ *
+ * Returns: 0 on success and -ETIMEDOUT upon a timeout. In either
+ * case, the last read value at @args is stored in @val. Must not
+ * be called from atomic context if sleep_us or timeout_us are used.
  */
 #define read_poll_timeout(op, val, cond, sleep_us, timeout_us, \
 				sleep_before_read, args...) \
@@ -64,22 +64,22 @@
  * @op: accessor function (takes @args as its arguments)
  * @val: Variable to read the value into
  * @cond: Break condition (usually involving @val)
- * @delay_us: Time to udelay between reads in us (0 tight-loops).  Should
- *            be less than ~10us since udelay is used (see
- *            Documentation/timers/timers-howto.rst).
+ * @delay_us: Time to udelay between reads in us (0 tight-loops). Please
+ *            read udelay() function description for details and
+ *            limitations.
  * @timeout_us: Timeout in us, 0 means never timeout
  * @delay_before_read: if it is true, delay @delay_us before read.
  * @args: arguments for @op poll
  *
- * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
- * case, the last read value at @args is stored in @val.
- *
  * This macro does not rely on timekeeping.  Hence it is safe to call even when
  * timekeeping is suspended, at the expense of an underestimation of wall clock
  * time, which is rather minimal with a non-zero delay_us.
  *
  * When available, you'll probably want to use one of the specialized
  * macros defined below rather than this macro directly.
+ *
+ * Returns: 0 on success and -ETIMEDOUT upon a timeout. In either
+ * case, the last read value at @args is stored in @val.
  */
 #define read_poll_timeout_atomic(op, val, cond, delay_us, timeout_us, \
 					delay_before_read, args...) \
@@ -119,17 +119,17 @@
  * @addr: Address to poll
  * @val: Variable to read the value into
  * @cond: Break condition (usually involving @val)
- * @sleep_us: Maximum time to sleep between reads in us (0
- *            tight-loops).  Should be less than ~20ms since usleep_range
- *            is used (see Documentation/timers/timers-howto.rst).
+ * @sleep_us: Maximum time to sleep between reads in us (0 tight-loops). Please
+ *            read usleep_range() function description for details and
+ *            limitations.
  * @timeout_us: Timeout in us, 0 means never timeout
  *
- * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
- * case, the last read value at @addr is stored in @val. Must not
- * be called from atomic context if sleep_us or timeout_us are used.
- *
  * When available, you'll probably want to use one of the specialized
  * macros defined below rather than this macro directly.
+ *
+ * Returns: 0 on success and -ETIMEDOUT upon a timeout. In either
+ * case, the last read value at @addr is stored in @val. Must not
+ * be called from atomic context if sleep_us or timeout_us are used.
  */
 #define readx_poll_timeout(op, addr, val, cond, sleep_us, timeout_us)	\
 	read_poll_timeout(op, val, cond, sleep_us, timeout_us, false, addr)
@@ -140,16 +140,16 @@
  * @addr: Address to poll
  * @val: Variable to read the value into
  * @cond: Break condition (usually involving @val)
- * @delay_us: Time to udelay between reads in us (0 tight-loops).  Should
- *            be less than ~10us since udelay is used (see
- *            Documentation/timers/timers-howto.rst).
+ * @delay_us: Time to udelay between reads in us (0 tight-loops). Please
+ *            read udelay() function description for details and
+ *            limitations.
  * @timeout_us: Timeout in us, 0 means never timeout
  *
- * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
- * case, the last read value at @addr is stored in @val.
- *
  * When available, you'll probably want to use one of the specialized
  * macros defined below rather than this macro directly.
+ *
+ * Returns: 0 on success and -ETIMEDOUT upon a timeout. In either
+ * case, the last read value at @addr is stored in @val.
  */
 #define readx_poll_timeout_atomic(op, addr, val, cond, delay_us, timeout_us) \
 	read_poll_timeout_atomic(op, val, cond, delay_us, timeout_us, false, addr)
diff --git a/include/linux/phy.h b/include/linux/phy.h
index a98bc91..504766d 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1378,12 +1378,13 @@ int phy_read_mmd(struct phy_device *phydev, int devad, u32 regnum);
  * @regnum: The register on the MMD to read
  * @val: Variable to read the register into
  * @cond: Break condition (usually involving @val)
- * @sleep_us: Maximum time to sleep between reads in us (0
- *            tight-loops).  Should be less than ~20ms since usleep_range
- *            is used (see Documentation/timers/timers-howto.rst).
+ * @sleep_us: Maximum time to sleep between reads in us (0 tight-loops). Please
+ *            read usleep_range() function description for details and
+ *            limitations.
  * @timeout_us: Timeout in us, 0 means never timeout
  * @sleep_before_read: if it is true, sleep @sleep_us before read.
- * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
+ *
+ * Returns: 0 on success and -ETIMEDOUT upon a timeout. In either
  * case, the last read value at @args is stored in @val. Must not
  * be called from atomic context if sleep_us or timeout_us are used.
  */
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index f9ccad3..75f162b 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -106,17 +106,17 @@ struct reg_sequence {
  * @addr: Address to poll
  * @val: Unsigned integer variable to read the value into
  * @cond: Break condition (usually involving @val)
- * @sleep_us: Maximum time to sleep between reads in us (0
- *            tight-loops).  Should be less than ~20ms since usleep_range
- *            is used (see Documentation/timers/timers-howto.rst).
+ * @sleep_us: Maximum time to sleep between reads in us (0 tight-loops). Please
+ *            read usleep_range() function description for details and
+ *            limitations.
  * @timeout_us: Timeout in us, 0 means never timeout
  *
- * Returns 0 on success and -ETIMEDOUT upon a timeout or the regmap_read
+ * This is modelled after the readx_poll_timeout macros in linux/iopoll.h.
+ *
+ * Returns: 0 on success and -ETIMEDOUT upon a timeout or the regmap_read
  * error return value in case of a error read. In the two former cases,
  * the last read value at @addr is stored in @val. Must not be called
  * from atomic context if sleep_us or timeout_us are used.
- *
- * This is modelled after the readx_poll_timeout macros in linux/iopoll.h.
  */
 #define regmap_read_poll_timeout(map, addr, val, cond, sleep_us, timeout_us) \
 ({ \
@@ -133,20 +133,20 @@ struct reg_sequence {
  * @addr: Address to poll
  * @val: Unsigned integer variable to read the value into
  * @cond: Break condition (usually involving @val)
- * @delay_us: Time to udelay between reads in us (0 tight-loops).
- *            Should be less than ~10us since udelay is used
- *            (see Documentation/timers/timers-howto.rst).
+ * @delay_us: Time to udelay between reads in us (0 tight-loops). Please
+ *            read udelay() function description for details and
+ *            limitations.
  * @timeout_us: Timeout in us, 0 means never timeout
  *
- * Returns 0 on success and -ETIMEDOUT upon a timeout or the regmap_read
- * error return value in case of a error read. In the two former cases,
- * the last read value at @addr is stored in @val.
- *
  * This is modelled after the readx_poll_timeout_atomic macros in linux/iopoll.h.
  *
  * Note: In general regmap cannot be used in atomic context. If you want to use
  * this macro then first setup your regmap for atomic use (flat or no cache
  * and MMIO regmap).
+ *
+ * Returns: 0 on success and -ETIMEDOUT upon a timeout or the regmap_read
+ * error return value in case of a error read. In the two former cases,
+ * the last read value at @addr is stored in @val.
  */
 #define regmap_read_poll_timeout_atomic(map, addr, val, cond, delay_us, timeout_us) \
 ({ \
@@ -177,17 +177,17 @@ struct reg_sequence {
  * @field: Regmap field to read from
  * @val: Unsigned integer variable to read the value into
  * @cond: Break condition (usually involving @val)
- * @sleep_us: Maximum time to sleep between reads in us (0
- *            tight-loops).  Should be less than ~20ms since usleep_range
- *            is used (see Documentation/timers/timers-howto.rst).
+ * @sleep_us: Maximum time to sleep between reads in us (0 tight-loops). Please
+ *            read usleep_range() function description for details and
+ *            limitations.
  * @timeout_us: Timeout in us, 0 means never timeout
  *
- * Returns 0 on success and -ETIMEDOUT upon a timeout or the regmap_field_read
+ * This is modelled after the readx_poll_timeout macros in linux/iopoll.h.
+ *
+ * Returns: 0 on success and -ETIMEDOUT upon a timeout or the regmap_field_read
  * error return value in case of a error read. In the two former cases,
  * the last read value at @addr is stored in @val. Must not be called
  * from atomic context if sleep_us or timeout_us are used.
- *
- * This is modelled after the readx_poll_timeout macros in linux/iopoll.h.
  */
 #define regmap_field_read_poll_timeout(field, val, cond, sleep_us, timeout_us) \
 ({ \
diff --git a/sound/soc/sof/ops.h b/sound/soc/sof/ops.h
index 2584621..d73644e 100644
--- a/sound/soc/sof/ops.h
+++ b/sound/soc/sof/ops.h
@@ -597,12 +597,12 @@ snd_sof_is_chain_dma_supported(struct snd_sof_dev *sdev, u32 dai_type)
  * @addr: Address to poll
  * @val: Variable to read the value into
  * @cond: Break condition (usually involving @val)
- * @sleep_us: Maximum time to sleep between reads in us (0
- *            tight-loops).  Should be less than ~20ms since usleep_range
- *            is used (see Documentation/timers/timers-howto.rst).
+ * @sleep_us: Maximum time to sleep between reads in us (0 tight-loops). Please
+ *            read usleep_range() function description for details and
+ *            limitations.
  * @timeout_us: Timeout in us, 0 means never timeout
  *
- * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
+ * Returns: 0 on success and -ETIMEDOUT upon a timeout. In either
  * case, the last read value at @addr is stored in @val. Must not
  * be called from atomic context if sleep_us or timeout_us are used.
  *

