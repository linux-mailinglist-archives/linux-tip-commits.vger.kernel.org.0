Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045012AD1C4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Nov 2020 09:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgKJIut (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Nov 2020 03:50:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59103 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726213AbgKJIus (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Nov 2020 03:50:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604998248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CUPbC36bNhgEeHhTK8bYaDtKD7TRWDMLJYdSByDYhoQ=;
        b=fFjVyqMOC6pNwjvvDVFsRiRpDZ9G+6NZnT01Ng9kqppSgBA6zBPu8v/gFENhvVltQgD8/K
        kRj7dtlndkHAJeQHpfts/pnBlmz/tAlUh1D4L0OnAS23xC7Xgb1ajtx5e2g2wlU/XPzjG1
        Q1NUT/5xaZhrt2XtFimlYkfFOVabIok=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-OdvL9oSJNoa9ijso1ei5ZA-1; Tue, 10 Nov 2020 03:50:46 -0500
X-MC-Unique: OdvL9oSJNoa9ijso1ei5ZA-1
Received: by mail-ed1-f71.google.com with SMTP id x15so3921201edr.10
        for <linux-tip-commits@vger.kernel.org>; Tue, 10 Nov 2020 00:50:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CUPbC36bNhgEeHhTK8bYaDtKD7TRWDMLJYdSByDYhoQ=;
        b=RlAe5dnvy2FAYmeHqHJ/PB2Xp8FKHq7AWeaTqDIB9xKWsPlfAYaNp8mi6yIjx8jX+u
         DCz6QgRk1Xld3MS7nYJxfbsAYiUprgIkHsT1YsxQIdu37om8nLm4y0fH1UH3NNFNA2ch
         7z97PVaC6w92IuqttdIcKF5rtpOWnLInu7Dw573hEQHktV0abL+dek8DppQroeQOAM9n
         isvZdHRDhgNtuWlwtEM0Oj4RaoJvMKp4Z4IUWuToeWfmfGuAAYZmdJXOMwT3XZ4JNCti
         VAnTKZ7GPVgzMPZuHGzH0rZopX0A4JFk5FUOe3PXSzWz9l4+eEgkLGyoGq/OamrFcBRs
         d5Kw==
X-Gm-Message-State: AOAM532Hj9Qr2KHEVp4BTGlvCOKIae2C0pBOoNSRSvZWKF+bxtPu+wYt
        rYva9uObkiAHtISXstJfO3CF2vn5V2myO8Kr80rOnB9OtUJMz9uOykLZE0p5ut0H+985nMFiWbE
        93qQUNsP5uaINFN5WLxHgSNbDKmBS7Wc=
X-Received: by 2002:aa7:cd56:: with SMTP id v22mr20488893edw.245.1604998244811;
        Tue, 10 Nov 2020 00:50:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx35WhhYs7bXw5tdmtzhwGt5fe7Pcd7wc3tI61z+hFz90lglH4wBeVtEpkrFYUbjVb7L9Qv8w==
X-Received: by 2002:aa7:cd56:: with SMTP id v22mr20488883edw.245.1604998244638;
        Tue, 10 Nov 2020 00:50:44 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id l20sm10105014eja.40.2020.11.10.00.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 00:50:43 -0800 (PST)
To:     Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>
Cc:     Jim Mattson <jmattson@google.com>, Qian Cai <cai@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>, x86 <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <20201030190807.GA13884@agluck-desk2.amr.corp.intel.com>
 <160431588828.397.16468104725047768957.tip-bot2@tip-bot2>
 <3f863634cd75824907e8ccf8164548c2ef036f20.camel@redhat.com>
 <bfc274fc27724ea39ecac1e7ac834ed8@intel.com>
 <CALMp9eTFaiYkTnVe8xKzg40E4nZ3rAOii0O06bTy0+oLNjyKhA@mail.gmail.com>
 <a22b5468e1c94906b72c4d8bc83c0f64@intel.com>
 <20201109232402.GA25492@agluck-desk2.amr.corp.intel.com>
 <20201110063151.GB7290@nazgul.tnic>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] x86/mce: Check for hypervisor before enabling additional
 error logging
Message-ID: <094c2395-b1b3-d908-657c-9bd4144e40ac@redhat.com>
Date:   Tue, 10 Nov 2020 09:50:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201110063151.GB7290@nazgul.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 10/11/20 07:31, Borislav Petkov wrote:
>>   
>> +	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
>> +		return;
>> +
> Frankly, I'm tired of wagging the dog because the tail can't. If
> qemu/kvm can't emulate a CPU model fully then it should ignore those
> unknown MSR accesses by default, i.e., that "ignore_msrs" functionality
> should be on by default I'd say...
> 
> We certainly can't be sprinkling this check everytime the kernel tries
> to do something as basic as read an MSR.

You don't have to, also because it's wrong.  Fortunately it's much 
simpler than that:

1) ignore_msrs _cannot_ be on by default.  You cannot know in advance 
that for all non-architectural MSRs it's okay for them to read as zero 
and eat writes.  For some non-architectural MSR which never reads as 
zero on real hardware, who knows that there isn't some code using the 
contents of the MSR as a divisor, and causing a division by zero 
exception with ignore_msrs=1?

2) it's not just KVM.  _Any_ hypervisor is bound to have this issue for 
some non-architectural MSRs.  KVM just gets the flak because Linux CI 
environments (for obvious reasons) use it more than they use Hyper-V or 
ESXi or VirtualBox.

3) because of (1) and (2), the solution is very simple.  If the MSR is 
architectural, its absence is a KVM bug and we'll fix it in all stable 
versions.  If the MSR is not architectural (and 17Fh isn't; not only 
it's not mentioned in the SDM, even Google is failing me), never ever 
assume that the CPUID family/model/stepping implies a given MSR is 
there, and just use rdmsr_safe/wrmsr_safe.

So, for this patch,

Nacked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

