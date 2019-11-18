Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 189A7FFD90
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Nov 2019 05:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfKRElH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 17 Nov 2019 23:41:07 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:34069 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726314AbfKRElH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 17 Nov 2019 23:41:07 -0500
X-IronPort-AV: E=Sophos;i="5.68,319,1569254400"; 
   d="scan'208";a="78647102"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Nov 2019 12:41:04 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id B0BEA406AB15;
        Mon, 18 Nov 2019 12:32:50 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Mon, 18 Nov 2019 12:41:05 +0800
Subject: Re: [tip: x86/cleanups] x86/numa: Fix typo
To:     Borislav Petkov <bp@alien8.de>
CC:     Ingo Molnar <mingo@kernel.org>,
        <linux-tip-commits@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <hpa@zytor.com>, <luto@kernel.org>, <peterz@infradead.org>,
        <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
References: <20191115050828.2138-1-ruansy.fnst@cn.fujitsu.com>
 <157380293598.29467.2287139923549118344.tip-bot2@tip-bot2>
 <20191115082604.GA18929@zn.tnic> <20191115094009.GA25874@gmail.com>
 <9c43f148-479a-0aca-1577-30f686dcc90e@cn.fujitsu.com>
 <20191115104113.GJ18929@zn.tnic>
 <756e5529-5550-f4d3-ba8b-8d247a479f31@cn.fujitsu.com>
 <20191115113838.GK18929@zn.tnic>
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <d1a89cbe-0b2b-3f28-8097-a435ac28b1e7@cn.fujitsu.com>
Date:   Mon, 18 Nov 2019 12:42:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191115113838.GK18929@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: B0BEA406AB15.A87F7
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Sorry for the weekend latency.

On 11/15/19 7:38 PM, Borislav Petkov wrote:
> On Fri, Nov 15, 2019 at 07:13:59PM +0800, Cao jin wrote:
>> I still need my colleague to send the patches for me for the time being,
>> since the patches are removed now, so I am actually asking: does these 2
>> patches need to be resent with my SOB & my college's SOB, or maintainer
>> can do that for us?
>>
>> Not aware where I am wrong.
> 
> Ok, lemme try again:
> 
> If you send someone else's patch, you need to denote that the patch
> has been handled by you too. The reason this is done is so that it is
> crystal clear how a patch has found its way upstream: from the author,
> through the sender, then through the upstream maintainer and ending up
> in the upstream kernel.
> 
> IOW, the SOB chain needs to *show* that:
> 
> Signed-off-by: Patch Author
> Signed-off-by: Patch Sender
> Signed-off-by: Subsystem maintainer
> 
> You can find a gazillion examples for this in git history, some of them,
> unfortunately incorrect. Hopefully a small number.
> 
> And to answer your question: yes, the SOB needs to come from your
> colleague and upstream maintainers cannot do that for you. The SOB is
> his to give and cannot simply be slapped by maintainers at will because
> it entails the Certificate of Origin. That's also in the link I pointed
> you to earlier.
> 
> All clear? Or need more clarification?
> 
> If so, don't hesitate to ask.
> 
> HTH.
> 

I think I am all clear now. Thanks very much, Borislav.

-- 
Sincerely,
Cao jin


