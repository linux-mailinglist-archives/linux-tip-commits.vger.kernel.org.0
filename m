Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE11FDAD8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Nov 2019 11:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfKOKLw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Nov 2019 05:11:52 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:56564 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725829AbfKOKLw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Nov 2019 05:11:52 -0500
X-IronPort-AV: E=Sophos;i="5.68,307,1569254400"; 
   d="scan'208";a="78510788"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Nov 2019 18:11:51 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 725264B6EC71;
        Fri, 15 Nov 2019 18:03:37 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Fri, 15 Nov 2019 18:11:57 +0800
Subject: Re: [tip: x86/cleanups] x86/numa: Fix typo
To:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
CC:     <linux-tip-commits@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <hpa@zytor.com>, <luto@kernel.org>, <peterz@infradead.org>,
        <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
References: <20191115050828.2138-1-ruansy.fnst@cn.fujitsu.com>
 <157380293598.29467.2287139923549118344.tip-bot2@tip-bot2>
 <20191115082604.GA18929@zn.tnic> <20191115094009.GA25874@gmail.com>
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <9c43f148-479a-0aca-1577-30f686dcc90e@cn.fujitsu.com>
Date:   Fri, 15 Nov 2019 18:12:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191115094009.GA25874@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: 725264B6EC71.A66F0
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 11/15/19 5:40 PM, Ingo Molnar wrote:
> * Borislav Petkov <bp@alien8.de> wrote:

>>
>> This is all fine and good but this one and the other patch doesn't have
>> the sender's SOB, i.e., that dude:
>>
>> From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
>>
>> and I was about to point that out but you applied them already.
>>
>> I'm guessing Shiyang is sending those because the author's mail has been
>> bouncing recently. I guess he left or so...
> 
> Thanks, I missed that. I've removed these commits from x86/cleanups for 
> the time being.
> 
> 	Ingo
> 

Does them need to be resent with my college's SOB?
-- 
Sincerely,
Cao jin


