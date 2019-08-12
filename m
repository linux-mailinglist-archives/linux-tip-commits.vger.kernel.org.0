Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAF1189EFB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Aug 2019 14:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfHLM6M (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 12 Aug 2019 08:58:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42157 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfHLM6M (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 12 Aug 2019 08:58:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7CCw4rY913410
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 12 Aug 2019 05:58:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7CCw4rY913410
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565614684;
        bh=/vWIPuqqcmV4ncD4F+mnVPU92vCEwG4t02RLeeViSfU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=qvbz5QY8ds08x0AekT7VQjP7fQrSICH4nQzgvjeFR1+mShT0Mi4K9M+X4SJ7Ks+Bb
         wBeBEuqbBaM+fMUjncxZZdLm9bFLM3du3zbhqnKMoKCux7gDSAimiryqwuSXyswajT
         aQAZyDGSkY5dLto+/t7G6apbDyzakb8Cg/5ibzFoU6B7C+tvEMMLvheilpElwf95Za
         cvK24cwmfi4YhJOKB6x0N5ygY+lTPeWiix07JNg6uJiAHCSQoQsiUPs6dAGEg//WYZ
         0Vrqigo9xocKAPL+T65ZhYEnRQuILUF/P84Z/BsZdZZpF4+ALaBLGoYQXK1Mc0uZDg
         KM7aZTW+A06jQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7CCw4MN913407;
        Mon, 12 Aug 2019 05:58:04 -0700
Date:   Mon, 12 Aug 2019 05:58:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vlastimil Babka <tipbot@zytor.com>
Message-ID: <tip-2e1da13fba4cb529c2c8c1d9f657690d1e853d7d@git.kernel.org>
Cc:     vbabka@suse.cz, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        mingo@kernel.org, hpa@zytor.com
Reply-To: vbabka@suse.cz, tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20190807130258.22185-1-vbabka@suse.cz>
References: <20190807130258.22185-1-vbabka@suse.cz>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/kconfig: Remove X86_DIRECT_GBPAGES dependency on
 !DEBUG_PAGEALLOC
Git-Commit-ID: 2e1da13fba4cb529c2c8c1d9f657690d1e853d7d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Commit-ID:  2e1da13fba4cb529c2c8c1d9f657690d1e853d7d
Gitweb:     https://git.kernel.org/tip/2e1da13fba4cb529c2c8c1d9f657690d1e853d7d
Author:     Vlastimil Babka <vbabka@suse.cz>
AuthorDate: Wed, 7 Aug 2019 15:02:58 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 12 Aug 2019 14:52:30 +0200

x86/kconfig: Remove X86_DIRECT_GBPAGES dependency on !DEBUG_PAGEALLOC

These days CONFIG_DEBUG_PAGEALLOC just compiles in the code that has to be
enabled on boot time, or with an extra config option, and only then are the
large page based direct mappings disabled.

Therefore remove the config dependency, allowing 1GB direct mappings with
debug_pagealloc compiled in but not enabled.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190807130258.22185-1-vbabka@suse.cz
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 222855cc0158..58eae28c3dd6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1503,7 +1503,7 @@ config X86_5LEVEL
 
 config X86_DIRECT_GBPAGES
 	def_bool y
-	depends on X86_64 && !DEBUG_PAGEALLOC
+	depends on X86_64
 	---help---
 	  Certain kernel features effectively disable kernel
 	  linear 1 GB mappings (even if the CPU otherwise
