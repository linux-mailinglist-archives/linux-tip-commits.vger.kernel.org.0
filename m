Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5300C340389
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Mar 2021 11:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhCRKjZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 18 Mar 2021 06:39:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56712 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhCRKjG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 18 Mar 2021 06:39:06 -0400
Date:   Thu, 18 Mar 2021 10:38:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616063936;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O2t2VuX4dAZ1DvnBSy56YvpC2/XAgdcUVKJ2f999NM4=;
        b=SW4V8XRlnoiEiPz7J0xjSlHXq48jml+0dOpFMWXqfGFCz4Nr3tBrmLDCL3KQv5WCcGPWKX
        r96H5iGYcYB2qvIUtQzGj9qjCeI0Zx0grgPtXKyn9SPXmYVBRfcS1Lkp/REUM6A9qe3Vkj
        7fof4EV0PGoCFMNfG33hnlW6X86fvV1MHcAme5ve2YkFoT2SXpmiLvbsA4hhevNOh9E/da
        sHmK9CfxF97IyOL3SNh04fBybl2B2RsBmZJn9L1cgaaLnhfADe5P3FwUMkRrHhO8cM1syK
        OA0QiK1Q1qBms7ZcH8z55IYoZtR4xzWzZw+ROzYaiaYGjQtv1v9jJrtPlyFQKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616063936;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O2t2VuX4dAZ1DvnBSy56YvpC2/XAgdcUVKJ2f999NM4=;
        b=Ev//fCXE3cLqq9CNC917cj2wbQJ0oUcTQYImRKjHNZa7SWejxBf6FwqD6Qtjbr4PnV2jvX
        3EPXCFHIJD1jqQCw==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] tools/x86/kcpuid: Check last token too
Cc:     Borislav Petkov <bp@suse.de>, Feng Tang <feng.tang@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210315125901.30315-1-bp@alien8.de>
References: <20210315125901.30315-1-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <161606393556.398.17576665580386583166.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     e20f67026b5ead2afc5627e98b45e6b65e7fb38c
Gitweb:        https://git.kernel.org/tip/e20f67026b5ead2afc5627e98b45e6b65e7fb38c
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Mon, 15 Mar 2021 13:08:35 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 18 Mar 2021 11:36:01 +01:00

tools/x86/kcpuid: Check last token too

Input lines like

  0x8000001E,     0, EAX,   31:0, Extended APIC ID

where the short name is missing lead to a segfault because the loop
takes the long name for the short name and tokens[5] becomes NULL which
explodes later in strcpy().

Check its value too before further processing.

Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Feng Tang <feng.tang@intel.com>
Link: https://lkml.kernel.org/r/20210315125901.30315-1-bp@alien8.de
---
 tools/arch/x86/kcpuid/kcpuid.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 6048da3..dae7551 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -324,6 +324,8 @@ static int parse_line(char *line)
 		str = NULL;
 	}
 	tokens[5] = strtok(str, "\n");
+	if (!tokens[5])
+		goto err_exit;
 
 	/* index/main-leaf */
 	index = strtoull(tokens[0], NULL, 0);
