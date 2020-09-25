Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D897278C89
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Sep 2020 17:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgIYPZC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 25 Sep 2020 11:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgIYPZC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 25 Sep 2020 11:25:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43697C0613CE;
        Fri, 25 Sep 2020 08:25:02 -0700 (PDT)
Date:   Fri, 25 Sep 2020 15:24:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601047500;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BaWy/UjQC4Yp6A/J5tS7lyY6rywwt+tqXKggckqF9yc=;
        b=Zm/kmWYErwl9tCqQL7dj7GvQzIFVDwFGOwbOooxngPtXdD7h6ajdgeasVKLml26quVr3Pu
        7TQ44+NFPxyARhCw04ooeoOIHq68Yg4Pq+pm6h5+O/jLon3mVzfwzJm00CxFpq2JSQwt74
        1pd6qo0QgTD8wSBX248+qSWDU81hDcYmJzLxdZrnZoXFq/C84yBY6DqYefmPC2Ld0XzGoG
        dIM5x7x/RpJZ81TGolfjVZKCjp0NfP0JEUuLfZXBStWyem2TrUsS23/zzOVN+aVUPfpxoo
        sUj2C/PZqhAGfyW7tzz3mnS6BPdybX52ZwMPcjlvvNzXvZa9p9RakN9c2p5wLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601047500;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BaWy/UjQC4Yp6A/J5tS7lyY6rywwt+tqXKggckqF9yc=;
        b=G/1Fve2MGzcjXLVjrb53FN8ZkhsDLDnjOlRpT/RpTl0otyAcMCUth11TOxpOXnETk5OKFD
        kEzRlimd9EzE/4Dg==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/sev-es: Use GHCB accessor for setting the MMIO
 scratch buffer
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>, Joerg Roedel <jroedel@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3Cba84deabdf44a7a880454fb351d189c6ad79d4ba=2E16010?=
 =?utf-8?q?41106=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Cba84deabdf44a7a880454fb351d189c6ad79d4ba=2E160104?=
 =?utf-8?q?1106=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <160104749936.7002.15136223385577937831.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     0ddfb1cf3b6b07c97cff16ea69931d986f9622ee
Gitweb:        https://git.kernel.org/tip/0ddfb1cf3b6b07c97cff16ea69931d986f9622ee
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Fri, 25 Sep 2020 08:38:26 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 25 Sep 2020 17:12:41 +02:00

x86/sev-es: Use GHCB accessor for setting the MMIO scratch buffer

Use ghcb_set_sw_scratch() to set the GHCB scratch field, which will also
set the corresponding bit in the GHCB valid_bitmap field to denote that
sw_scratch is actually valid.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
Link: https://lkml.kernel.org/r/ba84deabdf44a7a880454fb351d189c6ad79d4ba.1601041106.git.thomas.lendacky@amd.com
---
 arch/x86/kernel/sev-es.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 6fcfdd3..4a96726 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -751,7 +751,7 @@ static enum es_result vc_do_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
 	/* Can never be greater than 8 */
 	exit_info_2 = bytes;
 
-	ghcb->save.sw_scratch = ghcb_pa + offsetof(struct ghcb, shared_buffer);
+	ghcb_set_sw_scratch(ghcb, ghcb_pa + offsetof(struct ghcb, shared_buffer));
 
 	return sev_es_ghcb_hv_call(ghcb, ctxt, exit_code, exit_info_1, exit_info_2);
 }
