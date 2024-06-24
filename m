Return-Path: <linux-tip-commits+bounces-1524-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DE5915529
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Jun 2024 19:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6019286083
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Jun 2024 17:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0F419FA69;
	Mon, 24 Jun 2024 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wHcFs+IG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TrxpXIzv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEE519F46F;
	Mon, 24 Jun 2024 17:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719249279; cv=none; b=qF9cmnVkul4eWL6zCs6s2T0uEw1vMYLmqhPh1VbO2nFdv1yZLpf3O8E47cKR6ATL8n1JH+q3he2HPkS3IEdxGvduxsdf1TWKDamHtgRIhNodqEhjLbabK/BQl+FdJg6X3W+zsFdj4tf0iWOLAtdpWPU9YKtei/6wR9eNZUpY0iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719249279; c=relaxed/simple;
	bh=pLQKb4hkxxMqQhGoQsdgj9PEVlJq3hdtJKSuh1+z00I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=joqWK494MEWaPq/iAt2jLDreFdddO7V07dwNCnhrWWz4TL1FziNdUshTAQfbxKajBQ1xRvpy4hfDkfzEYDiKSo5Cy9SwKYN8uvvGxAGxwpcurstFO2OnvslRYgEHrDpezIrE7ZYqE8NWMJwphfAfIUowFy8tASUPhUGSkblmS9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wHcFs+IG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TrxpXIzv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Jun 2024 17:14:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719249274;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sD114X8x+UP8lTrRO+fWMrhEoh3BunE3e39m2uSHy6U=;
	b=wHcFs+IGivDDGfUbscSp33G/7UC3N3vazR3WDHveBMd/UizlFnwuYoSVKpa9XdpxXJ+D2L
	DVuMOusp/hT+44tZIF/kkwTInIW8a84FY/pCKonyOKmnYVzmlauMbcAhXxPUUXNCqdG/QK
	eMVsyfD6yI7FoXnkPLyfzwg8Dx1QO1QrTkO+raeJSz+m/2TqYNFQl8q6zFZXKMJdvU+EQD
	ykdfn4vm9WbEYYrWLfsi6HQyoY3J07blR3gBdndjvRGutP1GeRbM92IyIRl+dzAxjXi2iT
	1JDPk/mYDw9NrLRsQ5UgjchualAe6ZD2YNUV7He72+wh/1OFzXhzMNYKkQc1cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719249274;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sD114X8x+UP8lTrRO+fWMrhEoh3BunE3e39m2uSHy6U=;
	b=TrxpXIzvnbxZviGDB5xpRer+sBf/mMLxAbEhv75WA7l7EXadgbs1qq7Sn90YPe4qWlAHud
	RoFlSTHHUMeq/tDQ==
From: "tip-bot2 for Alexey Makhalov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/vmware] ptp/vmware: Use VMware hypercall API
Cc: Alexey Makhalov <alexey.makhalov@broadcom.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240613191650.9913-3-alexey.makhalov@broadcom.com>
References: <20240613191650.9913-3-alexey.makhalov@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171924927384.10875.12865274475367115285.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/vmware branch of tip:

Commit-ID:     b1df9cbd7a70b7e2fc7366f4689dcbc26433a127
Gitweb:        https://git.kernel.org/tip/b1df9cbd7a70b7e2fc7366f4689dcbc26433a127
Author:        Alexey Makhalov <alexey.makhalov@broadcom.com>
AuthorDate:    Thu, 13 Jun 2024 12:16:44 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 24 Jun 2024 07:10:38 +02:00

ptp/vmware: Use VMware hypercall API

Switch from VMWARE_HYPERCALL macro to vmware_hypercall API.
Eliminate arch specific code. No functional changes intended.

Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240613191650.9913-3-alexey.makhalov@broadcom.com
---
 drivers/ptp/ptp_vmw.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/ptp/ptp_vmw.c b/drivers/ptp/ptp_vmw.c
index 7ec9035..20ab05c 100644
--- a/drivers/ptp/ptp_vmw.c
+++ b/drivers/ptp/ptp_vmw.c
@@ -14,7 +14,6 @@
 #include <asm/hypervisor.h>
 #include <asm/vmware.h>
 
-#define VMWARE_MAGIC 0x564D5868
 #define VMWARE_CMD_PCLK(nr) ((nr << 16) | 97)
 #define VMWARE_CMD_PCLK_GETTIME VMWARE_CMD_PCLK(0)
 
@@ -24,15 +23,10 @@ static struct ptp_clock *ptp_vmw_clock;
 
 static int ptp_vmw_pclk_read(u64 *ns)
 {
-	u32 ret, nsec_hi, nsec_lo, unused1, unused2, unused3;
-
-	asm volatile (VMWARE_HYPERCALL :
-		"=a"(ret), "=b"(nsec_hi), "=c"(nsec_lo), "=d"(unused1),
-		"=S"(unused2), "=D"(unused3) :
-		"a"(VMWARE_MAGIC), "b"(0),
-		"c"(VMWARE_CMD_PCLK_GETTIME), "d"(0) :
-		"memory");
+	u32 ret, nsec_hi, nsec_lo;
 
+	ret = vmware_hypercall3(VMWARE_CMD_PCLK_GETTIME, 0,
+				&nsec_hi, &nsec_lo);
 	if (ret == 0)
 		*ns = ((u64)nsec_hi << 32) | nsec_lo;
 	return ret;

