Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08CBE84C9F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2019 15:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388079AbfHGNQu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Aug 2019 09:16:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41901 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387982AbfHGNQu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Aug 2019 09:16:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x77DGNXu2694547
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 7 Aug 2019 06:16:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x77DGNXu2694547
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565183784;
        bh=TLbuexVVkH4flQi/Zk02KNj+uo+Ez+kCrWCObIT/MRc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Q1NTA61Krfq6QsAbfegct7GGplRZD7veRN6mwRUJ4NwBQRLzmCfe2AxLY/GBsjyvk
         Au7ZtZTjeMR5gtZtNUY25WaaQDYhqjYGV4kRPnAWPBjjYb6kNZv34B+uT2zQPJ+r04
         MJdkW85ASnC2gVGeU0K3rXLBl9bPGnw0iGI9eAflS7dAPl6/Wb648d2p02xQ5vzsIW
         j91xe4mq/rj03yi8K1iMIKuum2ZgK48TeCyEB0k8v9HDwMcNyRUnwYBnyuBaPGUOzT
         pgaCmAbY9OA9jCV2CraqSc5fWgA3XKvB6dktWR24L87o7pz5TZ1c4SKHEocfUbBH9e
         QlaSR8L1bL6ew==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x77DGNFI2694544;
        Wed, 7 Aug 2019 06:16:23 -0700
Date:   Wed, 7 Aug 2019 06:16:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Gustavo A. R. Silva" <tipbot@zytor.com>
Message-ID: <tip-4ab9ab656a6cea5257bfa31f00c922d68f7a5c2f@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        gustavo@embeddedor.com, keescook@chromium.org, hpa@zytor.com
Reply-To: hpa@zytor.com, tglx@linutronix.de, keescook@chromium.org,
          gustavo@embeddedor.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190805195654.GA17831@embeddedor>
References: <20190805195654.GA17831@embeddedor>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/ptrace: Mark expected switch fall-through
Git-Commit-ID: 4ab9ab656a6cea5257bfa31f00c922d68f7a5c2f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.3 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Commit-ID:  4ab9ab656a6cea5257bfa31f00c922d68f7a5c2f
Gitweb:     https://git.kernel.org/tip/4ab9ab656a6cea5257bfa31f00c922d68f7a5c2f
Author:     Gustavo A. R. Silva <gustavo@embeddedor.com>
AuthorDate: Mon, 5 Aug 2019 14:56:54 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 7 Aug 2019 15:12:01 +0200

x86/ptrace: Mark expected switch fall-through

Mark switch cases where we are expecting to fall through.

Fix the following warning (Building: allnoconfig i386):

arch/x86/kernel/ptrace.c:202:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
   if (unlikely(value == 0))
      ^
arch/x86/kernel/ptrace.c:206:2: note: here
  default:
  ^~~~~~~

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20190805195654.GA17831@embeddedor

---
 arch/x86/kernel/ptrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 0fdbe89d0754..3c5bbe8e4120 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -201,6 +201,7 @@ static int set_segment_reg(struct task_struct *task,
 	case offsetof(struct user_regs_struct, ss):
 		if (unlikely(value == 0))
 			return -EIO;
+		/* Else, fall through */
 
 	default:
 		*pt_regs_access(task_pt_regs(task), offset) = value;
