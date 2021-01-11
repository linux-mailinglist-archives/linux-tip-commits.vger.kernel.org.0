Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81412F1EC4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 Jan 2021 20:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390713AbhAKTPe (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 11 Jan 2021 14:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390383AbhAKTPe (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 11 Jan 2021 14:15:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38DEC061786;
        Mon, 11 Jan 2021 11:14:53 -0800 (PST)
Date:   Mon, 11 Jan 2021 19:14:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610392491;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wMKpksQeNw2J4WuIigQd8lSlcw5aEFUcku4DAHtxxbA=;
        b=lSxjlCRNc/xWYmw0zoBCqaRBo8NvkRBSPtbvX5ZN1EF1dZ6dW0T2raN4EU2HszZ750/q+P
        Cd+7vPz/cWs+bQtBdwMV0i9u9EP2NJ5U7kWZlC5h2+HS0uyWyXv10pQMfE8WhqCBNhaCYW
        5OYQ4cYlHPt7tysma0LMklbQSpiP/JMyW1j52WWiA2zijYbNMbyCFYxRVvuwcYbeTXwwT6
        uJC3yMzp9tN5eh19xiabYuWmc/2+cQ+qlCngAyiYj6UGflVgI6SyIYgC1VDX7W0h5JT0C2
        s3FmYTqDNfyIizK5p/ddd1VCooNSadSGf5wdhPrINU/0VhDfv1ZIL9ZtqtxCrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610392491;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wMKpksQeNw2J4WuIigQd8lSlcw5aEFUcku4DAHtxxbA=;
        b=+QIVEE+74+S9amFbZSLOi27B2NS6S+TOhAb+YZLIzELQyGshD9Ynv1TuxhNNx7cOXUap6b
        OdEOMSsyYRKwYtAw==
From:   "tip-bot2 for Hyunwook (Wooky) Baek" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/sev-es: Handle string port IO to kernel memory properly
Cc:     "Hyunwook (Wooky) Baek" <baekhw@google.com>,
        Borislav Petkov <bp@suse.de>,
        David Rientjes <rientjes@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210110071102.2576186-1-baekhw@google.com>
References: <20210110071102.2576186-1-baekhw@google.com>
MIME-Version: 1.0
Message-ID: <161039249026.414.12255461373156299431.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     7024f60d655272bd2ca1d3a4c9e0a63319b1eea1
Gitweb:        https://git.kernel.org/tip/7024f60d655272bd2ca1d3a4c9e0a63319b1eea1
Author:        Hyunwook (Wooky) Baek <baekhw@google.com>
AuthorDate:    Sat, 09 Jan 2021 23:11:02 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 11 Jan 2021 20:01:52 +01:00

x86/sev-es: Handle string port IO to kernel memory properly

Don't assume dest/source buffers are userspace addresses when manually
copying data for string I/O or MOVS MMIO, as {get,put}_user() will fail
if handed a kernel address and ultimately lead to a kernel panic.

When invoking INSB/OUTSB instructions in kernel space in a
SEV-ES-enabled VM, the kernel crashes with the following message:

  "SEV-ES: Unsupported exception in #VC instruction emulation - can't continue"

Handle that case properly.

 [ bp: Massage commit message. ]

Fixes: f980f9c31a92 ("x86/sev-es: Compile early handler code into kernel image")
Signed-off-by: Hyunwook (Wooky) Baek <baekhw@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: David Rientjes <rientjes@google.com>
Link: https://lkml.kernel.org/r/20210110071102.2576186-1-baekhw@google.com
---
 arch/x86/kernel/sev-es.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 0bd1a0f..ab31c34 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -286,6 +286,12 @@ static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
 	u16 d2;
 	u8  d1;
 
+	/* If instruction ran in kernel mode and the I/O buffer is in kernel space */
+	if (!user_mode(ctxt->regs) && !access_ok(target, size)) {
+		memcpy(dst, buf, size);
+		return ES_OK;
+	}
+
 	switch (size) {
 	case 1:
 		memcpy(&d1, buf, 1);
@@ -335,6 +341,12 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 	u16 d2;
 	u8  d1;
 
+	/* If instruction ran in kernel mode and the I/O buffer is in kernel space */
+	if (!user_mode(ctxt->regs) && !access_ok(s, size)) {
+		memcpy(buf, src, size);
+		return ES_OK;
+	}
+
 	switch (size) {
 	case 1:
 		if (get_user(d1, s))
