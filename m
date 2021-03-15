Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E751133C054
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Mar 2021 16:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhCOPsS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Mar 2021 11:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbhCOPrz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Mar 2021 11:47:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F22FC061763;
        Mon, 15 Mar 2021 08:47:50 -0700 (PDT)
Date:   Mon, 15 Mar 2021 15:47:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615823265;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f9c/wOZGiMIVaSMEJLtoV5Qd1lXVlb5s8q8y6tOB/QU=;
        b=j2TCEiQd9aqbRxiJ7EZfsdwp/n+QTOUM5205ZqTmGVMIRL1z4mqYzWO6pb7hI5lD5dK1Pk
        nTF+yVLP9I3+bnTOnLj5NrIv9mLKCw3hUjsE9QdFhTRvTYAbwqIUjUWwJ6ldRM2DU3AJWz
        USSJQqG4MHvC3KoYzyCdLES6lJjZGnCYocToDOXyijuqv8uCjVsSt41jVa6NshhheHkbal
        ikCW/XETr2nCovKMcGIAkototPJXGVYRUYGhXEUxl0850doc/DCOx1kbizat5ODcYbLSfx
        UhWkjH2XZGbHTEgt1UB0pyoPJXdoajstdSR7ePiYcpIJ9YNoXrkk8+HhyD+fIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615823265;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f9c/wOZGiMIVaSMEJLtoV5Qd1lXVlb5s8q8y6tOB/QU=;
        b=4AMw4JSYCfX1Ec2TIvOcOADckVFnc6rB6HHgBz1qopXTpbC13myQG3UGq/P3c7jQab4H7r
        /4IwHgrcmsf95vCg==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/tools/insn_sanity: Convert to insn_decode()
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210304174237.31945-19-bp@alien8.de>
References: <20210304174237.31945-19-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <161582326470.398.7052927584859870714.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     a277ce601cd1c75412a82dfcff547b3173098ef0
Gitweb:        https://git.kernel.org/tip/a277ce601cd1c75412a82dfcff547b3173098ef0
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Sun, 22 Nov 2020 18:11:10 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Mar 2021 12:21:11 +01:00

x86/tools/insn_sanity: Convert to insn_decode()

Simplify code, no functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210304174237.31945-19-bp@alien8.de
---
 arch/x86/tools/insn_sanity.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/tools/insn_sanity.c b/arch/x86/tools/insn_sanity.c
index c6a0000..213f35f 100644
--- a/arch/x86/tools/insn_sanity.c
+++ b/arch/x86/tools/insn_sanity.c
@@ -218,8 +218,8 @@ static void parse_args(int argc, char **argv)
 
 int main(int argc, char **argv)
 {
+	int insns = 0, ret;
 	struct insn insn;
-	int insns = 0;
 	int errors = 0;
 	unsigned long i;
 	unsigned char insn_buff[MAX_INSN_SIZE * 2];
@@ -237,15 +237,15 @@ int main(int argc, char **argv)
 			continue;
 
 		/* Decode an instruction */
-		insn_init(&insn, insn_buff, sizeof(insn_buff), x86_64);
-		insn_get_length(&insn);
+		ret = insn_decode(&insn, insn_buff, sizeof(insn_buff),
+				  x86_64 ? INSN_MODE_64 : INSN_MODE_32);
 
 		if (insn.next_byte <= insn.kaddr ||
 		    insn.kaddr + MAX_INSN_SIZE < insn.next_byte) {
 			/* Access out-of-range memory */
 			dump_stream(stderr, "Error: Found an access violation", i, insn_buff, &insn);
 			errors++;
-		} else if (verbose && !insn_complete(&insn))
+		} else if (verbose && ret < 0)
 			dump_stream(stdout, "Info: Found an undecodable input", i, insn_buff, &insn);
 		else if (verbose >= 2)
 			dump_insn(stdout, &insn);
