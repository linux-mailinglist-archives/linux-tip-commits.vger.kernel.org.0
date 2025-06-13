Return-Path: <linux-tip-commits+bounces-5838-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35F8AD8CA3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 14:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA4E3B38BE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 12:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4977627462;
	Fri, 13 Jun 2025 12:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HvdIj8MG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tfyyus7o"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABC363A9;
	Fri, 13 Jun 2025 12:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749819520; cv=none; b=JDYh3BDm4lh/Q/3iqdsDamVmlINdbZV0igz6Yt7sNd27tuvBZxbf1EA8hKbhCviEwmc+K6uFMguXRqX7vQ+daSHpGCSQ8IplFQl0ntlHwPOQoTWhmYDKD/rVdxNRliV56HSgqsJqKn7rGTH5vh2SX8b8mIrGF9+V/wkaD3+cqT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749819520; c=relaxed/simple;
	bh=HB0wDOJzS3HrgqoMV7bcUDMPRb1iMOcaGiVDH6zpgx4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=i5OCFNbtkLwsKfWe9FaiH1/BIDLfYIpjh7CWvzRyoaSQ/NMo2600VZmGDZ1uLyVmjXnJiyRyYwf0PC9ut26cVJPZOCQHpSIXac4YVGpaVWb9uiiNB7TnHF1xp/BPcMEViXW8Xpjy77kBOBiAfXnEz9ut7mM+crCtp+W/gLPfgKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HvdIj8MG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tfyyus7o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 12:58:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749819509;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CTuNRKXMmRC4Te9gor2dckm4EkkJG0/0j525o8lM6z8=;
	b=HvdIj8MGEB/8x5NboKXz5B5/RytGWKRrP161XGmvsQMHNP+OtuLs+0HcsKVytcxNWW3TRk
	Is7ajaU3YJp8NDtTFqhAnZXp7ZDCl7xUsxTBXWypvrUCQk+G1RHiOIDNFW3OzZJLI5GE2e
	/pu8+QWWOMTYqHW4gSTczY3Nxl+QeU1EQdVAoWAlSdorSwBXA0CIKPKPuiHr73+FL9nqok
	NChlGyvFCpTOOqxwn6jw51J1zz9oV+Qu6xernD/DAFQDd+YwHtJwW+glULMq+bVY4lcmDr
	VMJ+gSUc31B1EZ5P63Ey/UdL53BhM+lyxkdIbnEchR8ikKDNgW8uRRXnN3ZDfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749819509;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CTuNRKXMmRC4Te9gor2dckm4EkkJG0/0j525o8lM6z8=;
	b=Tfyyus7o6CU5UZgrdJzVS0sGisNkbNhCYtVOXN3E4InDzTWsYm66SIhHgJv0k6OHIFkS6Q
	zvVzfPgc2IkGDyDw==
From: "tip-bot2 for Viresh Kumar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] smp: Fix typo in comment for raw_smp_processor_id()
Cc: Boqun Feng <boqun.feng@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cd096779819962c305b85cd12bda41b593e0981aa=2E17495?=
 =?utf-8?q?36622=2Egit=2Eviresh=2Ekumar=40linaro=2Eorg=3E?=
References: =?utf-8?q?=3Cd096779819962c305b85cd12bda41b593e0981aa=2E174953?=
 =?utf-8?q?6622=2Egit=2Eviresh=2Ekumar=40linaro=2Eorg=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174981950839.406.6889829329461040913.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     09735f0624b494c0959f3327af009283567af320
Gitweb:        https://git.kernel.org/tip/09735f0624b494c0959f3327af009283567af320
Author:        Viresh Kumar <viresh.kumar@linaro.org>
AuthorDate:    Tue, 10 Jun 2025 13:27:13 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 13 Jun 2025 14:48:54 +02:00

smp: Fix typo in comment for raw_smp_processor_id()

The comment in `smp.h` incorrectly refers to `raw_processor_id()`
instead of the correct function name `raw_smp_processor_id()`.

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/all/d096779819962c305b85cd12bda41b593e0981aa.1749536622.git.viresh.kumar@linaro.org

---
 include/linux/smp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index f1aa095..bea8d28 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -234,7 +234,7 @@ static inline int get_boot_cpu_id(void)
 #endif /* !SMP */
 
 /**
- * raw_processor_id() - get the current (unstable) CPU id
+ * raw_smp_processor_id() - get the current (unstable) CPU id
  *
  * For then you know what you are doing and need an unstable
  * CPU id.

