Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46173FD860
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Nov 2019 10:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfKOJH1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Nov 2019 04:07:27 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:51336 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725829AbfKOJH1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Nov 2019 04:07:27 -0500
X-IronPort-AV: E=Sophos;i="5.68,307,1569254400"; 
   d="scan'208";a="78502335"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Nov 2019 17:07:25 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id DDB4D4CE1C11;
        Fri, 15 Nov 2019 16:59:13 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Fri, 15 Nov 2019 17:07:34 +0800
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
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <550ce44a-2b61-42ea-46c1-22a6a4976e5f@cn.fujitsu.com>
Date:   Fri, 15 Nov 2019 17:08:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191115084509.GC18929@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: DDB4D4CE1C11.AAC2E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 11/15/19 4:45 PM, Borislav Petkov wrote:
> On Fri, Nov 15, 2019 at 04:41:13PM +0800, Cao jin wrote:
>> Sorry for the confusion. I asked my college to send the patch for me
>> because my git send-email has been down for a while,
> 
> Your "git send-email has been down"? What does that even mean?
> 
my send-email always give me the following msg:

Net::SMTP>>> Net::SMTP(3.11)
Net::SMTP>>>   Net::Cmd(3.11)
Net::SMTP>>>     Exporter(5.73)
Net::SMTP>>>   IO::Socket::IP(0.39)
Net::SMTP>>>     IO::Socket(1.39)
Net::SMTP>>>       IO::Handle(1.39)
Net::SMTP=GLOB(0x557db0534920)<<< 220 G08CNEXCHPEKD01.g08.fujitsu.local
Microsoft ESMTP MAIL Service ready at Fri, 15 Nov 2019 16:49:11 +0800
Net::SMTP=GLOB(0x557db0534920)>>> EHLO TSO.g08.fujitsu.local
Net::SMTP=GLOB(0x557db0534920)<<< 250-G08CNEXCHPEKD01.g08.fujitsu.local
Hello [10.167.226.60]
Net::SMTP=GLOB(0x557db0534920)<<< 250-SIZE
Net::SMTP=GLOB(0x557db0534920)<<< 250-PIPELINING
Net::SMTP=GLOB(0x557db0534920)<<< 250-DSN
Net::SMTP=GLOB(0x557db0534920)<<< 250-ENHANCEDSTATUSCODES
Net::SMTP=GLOB(0x557db0534920)<<< 250-STARTTLS
Net::SMTP=GLOB(0x557db0534920)<<< 250-X-ANONYMOUSTLS
Net::SMTP=GLOB(0x557db0534920)<<< 250-AUTH NTLM
Net::SMTP=GLOB(0x557db0534920)<<< 250-X-EXPS GSSAPI NTLM
Net::SMTP=GLOB(0x557db0534920)<<< 250-8BITMIME
Net::SMTP=GLOB(0x557db0534920)<<< 250-BINARYMIME
Net::SMTP=GLOB(0x557db0534920)<<< 250-CHUNKING
Net::SMTP=GLOB(0x557db0534920)<<< 250-XEXCH50
Net::SMTP=GLOB(0x557db0534920)<<< 250-XRDST
Net::SMTP=GLOB(0x557db0534920)<<< 250 XSHADOW
Net::SMTP=GLOB(0x557db0534920)>>> STARTTLS
Net::SMTP=GLOB(0x557db0534920)<<< 220 2.0.0 SMTP server ready
STARTTLS failed! hostname verification failed at
/usr/libexec/git-core/git-send-email line 1515.

But nothing changed in my configuration, several weeks ago, it can
send-email.

> If you do ask your colleague to send patches for you, he needs to add
> his SOB under yours because it shows this way that the patch went
> through him and it is important to know the path a patch took upstream.
> 

Got it, thanks. I thought SOB is more of the responsibility of the patch
content.

>> I guess it is because our mail server is upgrading.
> 
> Well, something's happening because I've received a couple of bounces
> from your mail address in the past weeks.
> 

Yeah, weird, I can receive from & send to you in thunderbird without any
error.

-- 
Sincerely,
Cao jin


