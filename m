Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85248FDAD7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Nov 2019 11:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfKOKL3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Nov 2019 05:11:29 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:54953 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725829AbfKOKL3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Nov 2019 05:11:29 -0500
X-IronPort-AV: E=Sophos;i="5.68,307,1569254400"; 
   d="scan'208";a="78510747"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Nov 2019 18:11:27 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 018AE4CE1BE4;
        Fri, 15 Nov 2019 18:03:16 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Fri, 15 Nov 2019 18:11:36 +0800
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
 <20191115082604.GA18929@zn.tnic>
 <73ffdd4c-d74d-e3c0-7cd5-f97e7061caeb@cn.fujitsu.com>
 <20191115084509.GC18929@zn.tnic>
 <550ce44a-2b61-42ea-46c1-22a6a4976e5f@cn.fujitsu.com>
 <20191115093236.GG18929@zn.tnic>
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <c328744b-2870-b5bd-0b1a-a092a6aaf8ed@cn.fujitsu.com>
Date:   Fri, 15 Nov 2019 18:12:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191115093236.GG18929@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: 018AE4CE1BE4.A20EA
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 11/15/19 5:32 PM, Borislav Petkov wrote:
> On Fri, Nov 15, 2019 at 05:08:26PM +0800, Cao jin wrote:
>> Net::SMTP=GLOB(0x557db0534920)<<< 220 G08CNEXCHPEKD01.g08.fujitsu.local
>> Microsoft ESMTP MAIL Service ready at Fri, 15 Nov 2019 16:49:11 +0800
> 
> If that's exchange, it has been known to mangle patches and it is
> generally unsuitable for upstream work. Talk to your manager about using
> a linux solution for sending patches.

Out of my manger's boundary;)

> 
>> Net::SMTP=GLOB(0x557db0534920)<<< 220 2.0.0 SMTP server ready
>> STARTTLS failed! hostname verification failed at
> ^^^^^^^^^^^^^^^^^^
> 
> It complains about your hostname.

Did a little bit investigation, I don't think it is really related with
my hostname. So I might want to wait the mail server is upgraded and see.

> 
>> Got it, thanks. I thought SOB is more of the responsibility of the patch
>> content.
> 
> I will point you to a nice reading, once more:
> 
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
> 
> Make sure you look at it each time you're not sure about the SOB chain.
> 

Thanks very much, already found it.

-- 
Sincerely,
Cao jin


