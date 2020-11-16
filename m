Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13EBF2B3B36
	for <lists+linux-tip-commits@lfdr.de>; Mon, 16 Nov 2020 02:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgKPBsE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 15 Nov 2020 20:48:04 -0500
Received: from smtprelay0103.hostedemail.com ([216.40.44.103]:50448 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728010AbgKPBsE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 15 Nov 2020 20:48:04 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 3AFBB18225E1A;
        Mon, 16 Nov 2020 01:48:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:334:355:368:369:379:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2561:2564:2682:2685:2828:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4605:5007:6691:8957:9025:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12297:12438:12555:12679:12683:12696:12737:12740:12895:12986:13161:13229:13255:13439:13894:14181:14659:14721:21080:21324:21365:21451:21627:21740:21939:30030:30045:30054:30089:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: wine72_45072f727325
X-Filterd-Recvd-Size: 3673
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Mon, 16 Nov 2020 01:48:02 +0000 (UTC)
Message-ID: <720b8857ebbe1be81babd04463b865d94049c0a9.camel@perches.com>
Subject: Re: [tip: timers/core] timer_list: Use printk format instead of
 open-coded symbol lookup
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org
Date:   Sun, 15 Nov 2020 17:48:01 -0800
In-Reply-To: <160548066806.11244.12654291126762323623.tip-bot2@tip-bot2>
References: <20201104163401.GA3984@ls3530.fritz.box>
         <160548066806.11244.12654291126762323623.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Sun, 2020-11-15 at 22:51 +0000, tip-bot2 for Helge Deller wrote:
> The following commit has been merged into the timers/core branch of tip:
> 
> Commit-ID:     da88f9b3113620dcd30fc203236aa53d5430ee98
> Gitweb:        https://git.kernel.org/tip/da88f9b3113620dcd30fc203236aa53d5430ee98
> Author:        Helge Deller <deller@gmx.de>
> AuthorDate:    Wed, 04 Nov 2020 17:34:01 +01:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Sun, 15 Nov 2020 20:47:14 +01:00
> 
> timer_list: Use printk format instead of open-coded symbol lookup
> 
> Use the "%ps" printk format string to resolve symbol names.
> 
> This works on all platforms, including ia64, ppc64 and parisc64 on which
> one needs to dereference pointers to function descriptors instead of
> function pointers.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/r/20201104163401.GA3984@ls3530.fritz.box
> 
> 
> ---
>  kernel/time/timer_list.c | 66 +++++++++++----------------------------
>  1 file changed, 19 insertions(+), 47 deletions(-)
> 
> diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
> index acb326f..6939140 100644
> --- a/kernel/time/timer_list.c
> +++ b/kernel/time/timer_list.c
> @@ -42,24 +42,11 @@ static void SEQ_printf(struct seq_file *m, const char *fmt, ...)
>  	va_end(args);
>  }
>  
> 
> -static void print_name_offset(struct seq_file *m, void *sym)
> -{
> -	char symname[KSYM_NAME_LEN];
> -
> -	if (lookup_symbol_name((unsigned long)sym, symname) < 0)
> -		SEQ_printf(m, "<%pK>", sym);
> -	else
> -		SEQ_printf(m, "%s", symname);
> -}
> -
>  static void
>  print_timer(struct seq_file *m, struct hrtimer *taddr, struct hrtimer *timer,
>  	    int idx, u64 now)
>  {
> -	SEQ_printf(m, " #%d: ", idx);
> -	print_name_offset(m, taddr);
> -	SEQ_printf(m, ", ");
> -	print_name_offset(m, timer->function);
> +	SEQ_printf(m, " #%d: <%pK>, %ps", idx, taddr, timer->function);
>  	SEQ_printf(m, ", S:%02x", timer->state);
>  	SEQ_printf(m, "\n");

trivia:

This could be coalesced into a single line statement.

	SEQ_printf(m, "%d: <%pK>, %ps, S:%02x\n",
		   idx, taddr, timer->function, timer->state);

[]

> -	if (dev->set_state_periodic) {
> -		SEQ_printf(m, " periodic: ");
> -		print_name_offset(m, dev->set_state_periodic);
> -		SEQ_printf(m, "\n");
> -	}
> +	if (dev->set_state_periodic)
> +		SEQ_printf(m, " periodic:       %ps\n",
> +			dev->set_state_periodic);

There is now additional whitespace after periodic: and oneshot:

This _might_ break some silly script that uses fixed column alignment
for the SEQ_ output.

It does look nicer now though.

