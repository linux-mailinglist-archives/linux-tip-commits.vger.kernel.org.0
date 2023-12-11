Return-Path: <linux-tip-commits+bounces-2-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 686A180C8FC
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 Dec 2023 13:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08A4A1F21739
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 Dec 2023 12:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E873A26F;
	Mon, 11 Dec 2023 12:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CSV5GCrj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="19+g0zAr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AE0101;
	Mon, 11 Dec 2023 04:06:20 -0800 (PST)
Date: Mon, 11 Dec 2023 12:06:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702296378;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bl2tlV75de7fhE43nzDquqVGhEpeyvXDyhkJdtCkFhg=;
	b=CSV5GCrjnhWOyeRyiG1gd1lW3n5w1K4rShwujEAYWRFM1i+Uq2VpmK4x3ugYSGaH+IRO42
	/NMyjBfCyN0+Zb7Z8brAUB4KN5oLq60+wgxEvXEjeUrISzSEs/xI74es0anz3vSaVsrfw5
	WiaQ0Bvr9sLlNjHVMPs+JjpOopVN5o5XyoEplaHIPrQJSAgQbO1VGaZMw0dpbsP4xTm3cX
	jmOBk4tlobgoj78Av99W4Nawz18jlfk4kgf0HkovoCpioFsHpgFIsazX1nq7NIOSLzHqcN
	XiI5WjLGhtIc+9gpBhSQB9j9wBftcOLo5cLd1LpudlKmdAC9k1pRVmdDaE71Eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702296378;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bl2tlV75de7fhE43nzDquqVGhEpeyvXDyhkJdtCkFhg=;
	b=19+g0zAr8ZoeYSOT6DMBoQjarEol7zGO7mJ4nj1SIzdRJW2VBc3MeJIFrcFrOJLpvfhsn9
	YPSNbAc2yqAK5+Cw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/percpu: Avoid sparse warning with cast to named
 address space
Cc: kernel test robot <lkp@intel.com>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231204210320.114429-3-ubizjak@gmail.com>
References: <20231204210320.114429-3-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170229637722.398.17541780401553649834.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     3a1d3829e193c091475ceab481c5f8deab385023
Gitweb:        https://git.kernel.org/tip/3a1d3829e193c091475ceab481c5f8deab385023
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 04 Dec 2023 22:02:31 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 11 Dec 2023 11:47:15 +01:00

x86/percpu: Avoid sparse warning with cast to named address space

Teach sparse about __seg_fs and __seg_gs named address space
qualifiers to to avoid warnings about unexpected keyword at
the end of cast operator.

Reported-by: kernel test robot <lkp@intel.com>
Acked-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20231204210320.114429-3-ubizjak@gmail.com
Closes: https://lore.kernel.org/oe-kbuild-all/202310080853.UhMe5iWa-lkp@intel.com/
---
 arch/x86/include/asm/percpu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 3859aba..e56a378 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -36,6 +36,11 @@
 
 #ifdef CONFIG_CC_HAS_NAMED_AS
 
+#ifdef __CHECKER__
+#define __seg_gs		__attribute__((address_space(__seg_gs)))
+#define __seg_fs		__attribute__((address_space(__seg_fs)))
+#endif
+
 #ifdef CONFIG_X86_64
 #define __percpu_seg_override	__seg_gs
 #else

