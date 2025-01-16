Return-Path: <linux-tip-commits+bounces-3277-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6ABA13EC5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Jan 2025 17:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8558A3A6939
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Jan 2025 16:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FF022BACD;
	Thu, 16 Jan 2025 16:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SNhSWjk/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j7khzz7W"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E97422B8C4;
	Thu, 16 Jan 2025 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737043637; cv=none; b=dgkUyCz0XUgWs4jOtYFtAS9K5w6OFuy731VihjIFLV20h4zf8Jmy/qteM9yWWIEYGSVga2VsXY3ssi5v9bvZvkY7EW8sQ/mozM1DNVMqLJVRgD53Kw9WCU+RuAk3ce/zH6+P1GPCZ8Sf2JqZ/m7PmpgTIrFtlmYhuX1wMnW+bhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737043637; c=relaxed/simple;
	bh=P6RVuqFw0XJ2M8LekqDfEaigXOSMvbpuDCInHPMX4PA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YV5Fw1LnYsO8LqV1iKmKD6aGbMRtBusreQkRxT/CVUcDhttMqJWkrncwlEGjg4Xp7cE1b5vcEKxwPCOTzZH20tsr0T49Ee9PK4TrIAIRM15xYNuaMIr9sTZ66FAbbL3KH0eB+SegXiKmiLAgx4TISlkfVrm9ed9y4GjrfimqSIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SNhSWjk/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j7khzz7W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Jan 2025 16:07:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737043632;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTQZMZPLchG2XWJOmL4z1fB9pR+IOOoop6mJlQk43mU=;
	b=SNhSWjk/wHyCiAYJ0K/3QE9VPEORjZiQP3z8ZdqGZV+vFgzhdjk4nnisQF9TCEcmqc+e3B
	+Dku5DOYs1x0zfOTRLo0d8ECA/8UKq1srmwQx/cgJPPZPKTzU9SjEq6uEC20xSXby8tBA7
	vzcplpdkfryaUQI5SrR3LuUy7WolMT2yzlZUU00Yysv1z29SpA/g8q2VPLx1mJZJMMC4gf
	yj+XHeiyifPscNbaFqli0WWnuRdh0Oox8skonvKDvdLK/zUcDKpojTyMYc8GMs0Ww3ISSz
	KMhIBnBPnkhaMaX56ccbH7HXEzoq0U48P0JHdZH1vMGhROhn6o0VGgOtjVHtYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737043632;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTQZMZPLchG2XWJOmL4z1fB9pR+IOOoop6mJlQk43mU=;
	b=j7khzz7WsbxaSMAilRdnXOKSwCI3b7tCFZ5YiNUPCW1PmODPuAY5gOntFMebyD4AyrRj7M
	YyXPlv72p7a+XgBQ==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/asm: Make serialize() always_inline
Cc: kernel test robot <lkp@intel.com>, Juergen Gross <jgross@suse.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241218100918.22167-1-jgross@suse.com>
References: <20241218100918.22167-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173704363150.31546.14331192307031815487.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     ae02ae16b76160f0aeeae2c5fb9b15226d00a4ef
Gitweb:        https://git.kernel.org/tip/ae02ae16b76160f0aeeae2c5fb9b15226d00a4ef
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Wed, 18 Dec 2024 11:09:18 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 16 Jan 2025 16:51:17 +01:00

x86/asm: Make serialize() always_inline

In order to allow serialize() to be used from noinstr code, make it
__always_inline.

Fixes: 0ef8047b737d ("x86/static-call: provide a way to do very early static-call updates")
Closes: https://lore.kernel.org/oe-kbuild-all/202412181756.aJvzih2K-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241218100918.22167-1-jgross@suse.com
---
 arch/x86/include/asm/special_insns.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index aec6e2d..98bfc09 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -217,7 +217,7 @@ fail:
 
 #define nop() asm volatile ("nop")
 
-static inline void serialize(void)
+static __always_inline void serialize(void)
 {
 	/* Instruction opcode for SERIALIZE; supported in binutils >= 2.35. */
 	asm volatile(".byte 0xf, 0x1, 0xe8" ::: "memory");

