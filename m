Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B202B386D
	for <lists+linux-tip-commits@lfdr.de>; Sun, 15 Nov 2020 20:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbgKOTSW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 15 Nov 2020 14:18:22 -0500
Received: from smtprelay0252.hostedemail.com ([216.40.44.252]:34566 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726823AbgKOTSW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 15 Nov 2020 14:18:22 -0500
X-Greylist: delayed 574 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Nov 2020 14:18:21 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave03.hostedemail.com (Postfix) with ESMTP id 7A6BC181CB2BB
        for <linux-tip-commits@vger.kernel.org>; Sun, 15 Nov 2020 19:08:48 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 102221730853;
        Sun, 15 Nov 2020 19:08:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3351:3622:3865:3866:3867:3874:4321:5007:8660:10004:10400:10848:11026:11232:11657:11658:11783:11914:12043:12296:12297:12740:12895:13069:13148:13230:13311:13357:13439:13894:14659:14721:21080:21451:21627:21939:21990:30012:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: box80_261209727322
X-Filterd-Recvd-Size: 1579
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Sun, 15 Nov 2020 19:08:45 +0000 (UTC)
Message-ID: <7cb2266c9056f0106c5a870f741691143fcd0a77.camel@perches.com>
Subject: Re: [tip: core/entry] entry: Fix spelling/typo errors in irq entry
 code
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Date:   Sun, 15 Nov 2020 11:08:44 -0800
In-Reply-To: <160546656898.11244.12849621903409820578.tip-bot2@tip-bot2>
References: <20201104230157.3378023-1-ira.weiny@intel.com>
         <160546656898.11244.12849621903409820578.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Sun, 2020-11-15 at 18:56 +0000, tip-bot2 for Ira Weiny wrote:
> The following commit has been merged into the core/entry branch of tip:
[]
> s/assemenbly/assembly/
[]
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
[]
> @@ -438,7 +438,7 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs);
>   * @regs:	Pointer to pt_regs (NMI entry regs)
>   * @irq_state:	Return value from matching call to irqentry_nmi_enter()
>   *
> - * Last action before returning to the low level assmenbly code.
> + * Last action before returning to the low level assmebly code.

Might want to fix that typo typo fix...


